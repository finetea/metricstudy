
# coding: utf-8

# In[3]:

import pandas as pd
import csv
import re
import os

import multiprocessing




# In[4]:

#returns list of [market, stock_sybol] by querying database.

MAX_LIMIT = 100000
DATA_PATH = '..\\data'
US_STOCK_FILE_CSV = DATA_PATH + '\\us_stock.csv'

#limit means the number of results to be returned. 0 means everything
def getSymbols(start=0, limit=10):
    if limit <= 0:
        limit = MAX_LIMIT

    count = 0
    stocks = []

    with open(US_STOCK_FILE_CSV, 'rb') as stock_csv:
        lines = csv.reader(stock_csv, delimiter=',')
        for line in lines:
            market = line[0]
            stock = line[1]
            m = re.search('^[A-Z]+$', stock)
            if m:
                stock = m.group(0)
                count =  count + 1
                if count >= start:
						stocks.append([market, stock])
						limit = limit -1
						if limit == 0:
								break
    return stocks


# In[5]:

#returns db column names from the dataframe arg. names are a form of string without special characters.

def getFields(df):
    res = []
    y = df.iloc[:,0:1] #extract 1st column
    #y.iloc[1:10].values
    for z in y.iloc[:].values:
        x=re.sub('[ /,\.\&\-()\']','',z[0]) #remove special chars
        if isinstance(x, unicode):
            x = x.encode('UTF-8')
            #print type(x)
        res.append(x)
    return res


# In[6]:

def getTableName(data):
    y = data.iloc[:,0:1]
    val =  y.iloc[0:1].values[0][0]
    if isinstance(val, unicode):
        val = val.encode('UTF-8')
    
    if val.startswith('Revenue'):
        return 'IncomeStatement'
    elif val.startswith('Cash '):
        return 'BalanceSheet'
    elif val.startswith('Net '):
        return 'CashFlow'
    else:
        return None


# In[7]:

#open files for fin values

data_to_extract = {1:'IncomeStatement', #index in the dataframe, the name of financial data
                    3:'BalanceSheet',
                    5:'CashFlow'}

#returns dic of fin data type and writer handle
def openFinFiles():
    stocks = getSymbols(0,1)
    stock = stocks[0]
    #print stocks
    url = "https://www.google.com/finance?q="+stock[0]+"%3A"+stock[1]+"&fstype=ii"
    #print url
    df = pd.read_html(url, encoding=False)
    #print len(df)
   
    fin_files = {}
    for k in data_to_extract.keys():
        #print k
        
        ### get header string
        x = df[k]
        y = x.iloc[:,0:]
        fields = getFields(y)
        common_fields = ['symbol','date','period']
        fields = common_fields + fields
        header = ','.join(fields)
        #print header

        file_path = DATA_PATH + '\\' + data_to_extract[k] + '.csv'
        print file_path
        
        f = open(file_path, "wb")
        f.write(header)
        f.write('\r\n')

        fin_files[data_to_extract[k]] = f
        
    return fin_files
        
def closeFinFiles(fin_files):
    for k in fin_files.keys():
        fin_files[k].close()
    return


# In[8]:

def getPeriodAndDate(column_value):
    if isinstance(column_value, unicode):
        column_value = column_value.encode('UTF-8')

    column_value = re.sub('[\n]','',column_value) #remove special chars

    size = len(column_value)
    period = column_value[:size-11]
    date = column_value[size-10:]
    return (period,date)    


# In[9]:


# In[ ]:

def gatherFinValueAsync(stock, fin_incomestatement, fin_balancesheet, fin_cashflow):
    market = stock[0]
    stockname = stock[1]
    url = "https://www.google.com/finance?q="+market+"%3A"+stockname+"&fstype=ii"
    print url

    df = None
    try:
        df = pd.read_html(url, encoding=False)
    except Exception:
        print "Exception has been caught while processing [%s:%s]. No financial data."%(market, stockname)

    if df is None:
        return     #skip the rest if there is no financial data for this stock

    #print 'num of data is %d'%(len(df))

    if len(df) <= 1:
        print "Exception has been caught while processing [%s:%s]. No financial data."%(market, stockname)
        return    #skip the rest if there is no financial data for this stock

    #data_to_extract : this is declared already

    #columns_to_extract = [1,2,3,4]  #from 2015 to 2012

    for k in range(0, len(df)):
        data = df[k]
        columns_to_extract = range(1,len(data.columns.values)) # all data columns

        for c in columns_to_extract:
            #print getPeriodAndDate(data.columns.values[c])
            tablename = getTableName(data)
            (period, date) = getPeriodAndDate(data.columns.values[c])

            #common fields
            fields = [stockname, date, period]
            #row = '%s,%s,%s'%(stockname, date, period)

            #data fields
            y = data.iloc[:,c:c+1]
            for z in y.iloc[:].values:
                try:
                    val = z[0].encode('UTF-8')
                except AttributeError:
                    print z[0]
                    val = str(z[0])

                #print val
                if val == '-':
                    fields.append('NA')
                else:
                    fields.append(val)

            fields_str = ','.join(fields)
            #print fields_str

            if tablename == 'IncomeStatement':
					fin_incomestatement.append(fields_str)
            elif tablename == 'BalanceSheet':
					fin_balancesheet.append(fields_str)
            elif tablename == 'CashFlow':
					fin_cashflow.append(fields_str)
    return
    

def do_multirun(start, limit=10):
    if limit <= 0:
        limit = MAX_LIMIT
        
    cpu_cnt = multiprocessing.cpu_count()
    multi_factor = 2
    print "count of cpu : %d"%(cpu_cnt)
    
    m = multiprocessing.Manager()
    fin_incomestatement = m.list()
    fin_balancesheet = m.list()
    fin_cashflow = m.list()

    p = multiprocessing.Pool(cpu_cnt*multi_factor)
    
        
    stocks = getSymbols(start, limit) #get every symbol

    i = 300
    for stock in stocks[:limit]:
        p.apply_async(gatherFinValueAsync, [stock, fin_incomestatement, fin_balancesheet, fin_cashflow])
        i = i - 1
        if i == 0:
				os.system('sleep 10')
				i = 300
    p.close()
    p.join()

    #res

    fin_files = openFinFiles()

    for r in fin_incomestatement:
			fin_files[data_to_extract[1]].write(r+'\r\n')
    for r in fin_balancesheet:
			fin_files[data_to_extract[3]].write(r+'\r\n')
    for r in fin_cashflow:
			fin_files[data_to_extract[5]].write(r+'\r\n')

    closeFinFiles(fin_files)

    print "end of do_multirun"
    return  
    


def main():
		run = 100
		for x in range(0, 6300, run):
				do_multirun(x, x+run-1)
				os.system('sleep 10')


if __name__ == '__main__':
    main()
