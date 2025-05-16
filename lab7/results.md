## В рамках задачи выполнялось ознакомление и работа с библиотекой mappedbus. Изучена кодовая база и проанализированы примеры

### Результат работы программы:
#### Запускается 2 ObjectWriter, которые пишут данные в memory mapped файл. После этого запускается ObjectReader, считывающий данные из этого файла, при этом выводя данные в консоль:

Read: PriceUpdate [source=0, price=300, quantity=600], hasRecovered=true\
Read: PriceUpdate [source=1, price=412, quantity=824], hasRecovered=true\
Read: PriceUpdate [source=0, price=302, quantity=604], hasRecovered=true\
Read: PriceUpdate [source=1, price=414, quantity=828], hasRecovered=true\
Read: PriceUpdate [source=0, price=304, quantity=608], hasRecovered=true\
Read: PriceUpdate [source=1, price=416, quantity=832], hasRecovered=true\
Read: PriceUpdate [source=0, price=306, quantity=612], hasRecovered=true\
Read: PriceUpdate [source=1, price=418, quantity=836], hasRecovered=true\
Read: PriceUpdate [source=0, price=308, quantity=616], hasRecovered=true\

#### Как видно, считываются одновременно 2 различных источника. При этом если остановить один процесс ObjectWriter, то записывать будет уже один источник:
Read: PriceUpdate [source=0, price=640, quantity=1280], hasRecovered=true\
Read: PriceUpdate [source=0, price=642, quantity=1284], hasRecovered=true\
Read: PriceUpdate [source=0, price=644, quantity=1288], hasRecovered=true\
Read: PriceUpdate [source=0, price=646, quantity=1292], hasRecovered=true\
Read: PriceUpdate [source=0, price=648, quantity=1296], hasRecovered=true\
Read: PriceUpdate [source=0, price=650, quantity=1300], hasRecovered=true\
Read: PriceUpdate [source=0, price=652, quantity=1304], hasRecovered=true\
