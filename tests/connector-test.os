#Использовать asserts
#Использовать "../src"

Функция ПолучитьСписокТестов(МенеджерТестирования) Экспорт
	
	МассивТестов = Новый Массив;
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаютПараметрыЗаписиJson");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаютЗапросыБезУказанияСхемыURL");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПередачаПараметровВСтрокуЗапроса");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПередачаПараметровВСтрокуЗапросаКомбинированный");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПолучениеДвоичныхДанныхИзОтвета");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПолучениеТекстаИзОтвета");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПолучениеJsonИзОтветаКакСтруктура");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПараметрическоеПреобразованиеJsonИзОтвета");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПередачаПроизвольныхЗаголовков");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетОтправкаДанныхФормы");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетОтправкаJson");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетТаймаут");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетBasicAuth");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетDigestAuth");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетРедиректСОтносительнымАдресом");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетРедиректСАбсолютнымАдресом");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетПрерываниеЗацикленногоРедиректа");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетКодСостоянияИзОтвета");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетМетодOptions");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетМетодHead");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетМетодDelete");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетМетодPatch");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетУстановкаCookies");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетОтправкаCookies");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетОтправкаФайла");
	МассивТестов.Добавить("ТестДолжен_ПроверитьЧтоРаботаетОтправкаXMLСтрокой");
	МассивТестов.Добавить("ТестДолжен_ПроверитьПараметрыЗапросаТолькоКлюч");
	МассивТестов.Добавить("Тест_СложныеПараметрыЗапроса");
	
	Возврат МассивТестов;

КонецФункции

Процедура ТестДолжен_ПроверитьЧтоРаботаютПараметрыЗаписиJson() Экспорт

	ПараметрыЗаписиJSON = Новый Структура("ПереносСтрок", ПереносСтрокJSON.Нет);
	Json = Новый Структура;
	Json.Вставить("field", "value");
	Json.Вставить("field2", "value2");
	Результат = КоннекторHTTP.Post(
		"http://httpbin.org/anything",
		Неопределено,
		Json,
		Новый Структура("ПараметрыЗаписиJSON", ПараметрыЗаписиJSON)).Json();
	Ожидаем.Что(Результат["data"]).Равно("{""field"":""value"",""field2"":""value2""}");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаютЗапросыБезУказанияСхемыURL() Экспорт

	Ответ = КоннекторHTTP.Get("httpbin.org/get");
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.URL).Равно("http://httpbin.org/get");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПередачаПараметровВСтрокуЗапроса() Экспорт
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("name", СтрРазделить("Иванов,Петров", ","));
	ПараметрыЗапроса.Вставить("salary", Формат(100000, "ЧГ="));

 	Ответ = КоннекторHTTP.Get("https://httpbin.org/anything/params", ПараметрыЗапроса);
	Результат = Ответ.Json();

	Ожидаем.Что(Ответ.URL).Равно("https://httpbin.org/anything/params?name=%D0%98%D0%B2%D0%B0%D0%BD%D0%BE%D0%B2&name=%D0%9F%D0%B5%D1%82%D1%80%D0%BE%D0%B2&salary=100000");
 	Ожидаем.Что(Результат).ИмеетТип("Соответствие");
	Ожидаем.Что(Результат["url"]).Равно("https://httpbin.org/anything/params?name=Иванов&name=Петров&salary=100000");
	Ожидаем.Что(Результат["args"]).ИмеетТип("Соответствие");
	Ожидаем.Что(Результат["args"]["salary"]).Равно("100000");
	Ожидаем.Что(Результат["args"]["name"]).ИмеетТип("Массив");
	Ожидаем.Что(СтрСоединить(Результат["args"]["name"], ",")).Равно("Иванов,Петров");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПередачаПараметровВСтрокуЗапросаКомбинированный() Экспорт
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("name", СтрРазделить("Иванов,Петров", ","));
	ПараметрыЗапроса.Вставить("salary", Формат(100000, "ЧГ="));
	
	Ответ = КоннекторHTTP.Get("https://httpbin.org/anything/params?post=Программист", ПараметрыЗапроса);
	Результат = Ответ.Json();
	
	Ожидаем.Что(Результат).ИмеетТип("Соответствие");
	Ожидаем.Что(Результат["args"]).ИмеетТип("Соответствие");
	Ожидаем.Что(Результат["args"]["salary"]).Равно("100000");
	Ожидаем.Что(Результат["args"]["post"]).Равно("Программист");
	Ожидаем.Что(Результат["args"]["name"]).ИмеетТип("Массив");
	Ожидаем.Что(СтрСоединить(Результат["args"]["name"], ",")).Равно("Иванов,Петров");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПолучениеДвоичныхДанныхИзОтвета() Экспорт
	
	Результат = КоннекторHTTP.Get("http://httpbin.org/image/png").ДвоичныеДанные();

	Ожидаем.Что(Результат).ИмеетТип("ДвоичныеДанные");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПолучениеТекстаИзОтвета() Экспорт
	
	Результат = КоннекторHTTP.Get("http://httpbin.org/encoding/utf8").Текст();
	Ожидаем.Что(Результат).ИмеетТип("Строка");
	Ожидаем.Что(СтрНайти(Результат, "Зарегистрируйтесь сейчас на Десятую Международную")).Равно(3931);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПолучениеJsonИзОтветаКакСтруктура() Экспорт

	Параметры = Новый Структура("ПараметрыПреобразованияJSON", Новый Структура("ПрочитатьВСоответствие", Ложь));
	Результат = КоннекторHTTP.Get("http://httpbin.org/json", Неопределено, Параметры).Json();
	
	Ожидаем.Что(Результат).ИмеетТип("Структура");
	Ожидаем.Что(Результат.slideshow.title).Равно("Sample Slide Show");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПараметрическоеПреобразованиеJsonИзОтвета() Экспорт

	ПараметрыПреобразованияJSON = Новый Структура;
	ПараметрыПреобразованияJSON.Вставить("ИменаСвойствСоЗначениямиДата", "Дата");
	
	Json = Новый Структура;
	Json.Вставить("Дата", '20190121002400');
	Json.Вставить("Число", 5);
	Json.Вставить("Булево", True);
	Json.Вставить("Строка", "Привет");

	Параметры = Новый Структура("ПараметрыПреобразованияJSON", ПараметрыПреобразованияJSON);
	
	Ответ = КоннекторHTTP.Post("http://httpbin.org/post", Неопределено, Json, Параметры);
	Результат = Ответ.Json(); 

	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.URL).Равно("http://httpbin.org/post");
	Ожидаем.Что(Результат["json"]["Дата"]).Равно('20190121002400');
	Ожидаем.Что(Результат["json"]["Число"]).Равно(5);
	Ожидаем.Что(Результат["json"]["Булево"]).Равно(True);
	Ожидаем.Что(Результат["json"]["Строка"]).Равно("Привет");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПередачаПроизвольныхЗаголовков() Экспорт
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("X-My-Header", "Hello!!!");
	Ответ = КоннекторHTTP.Get("http://httpbin.org/headers", Неопределено, Новый Структура("Заголовки", Заголовки));
	Результат = Ответ.Json();

	Ожидаем.Что(Результат["headers"]["X-My-Header"]).Равно("Hello!!!");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетОтправкаДанныхФормы() Экспорт
	
	Данные = Новый Структура;
	Данные.Вставить("comments", "Постучать в дверь");
	Данные.Вставить("custemail", "vasya@mail.ru");
	Данные.Вставить("custname", "Вася");
	Данные.Вставить("custtel", "112");
	Данные.Вставить("delivery", "20:20");
	Данные.Вставить("size", "medium");
	Данные.Вставить("topping", СтрРазделить("bacon,mushroom", ","));
	
	Ответ = КоннекторHTTP.Post("http://httpbin.org/post", Данные);
	Результат = Ответ.Json();
	
	Ожидаем.Что(Ответ.URL).Равно("http://httpbin.org/post");

	Ожидаем.Что(Результат["form"]["size"]).Равно("medium");
	Ожидаем.Что(Результат["form"]["comments"]).Равно("Постучать в дверь");
	Ожидаем.Что(Результат["form"]["custemail"]).Равно("vasya@mail.ru");
	Ожидаем.Что(Результат["form"]["delivery"]).Равно("20:20");
	Ожидаем.Что(Результат["form"]["custtel"]).Равно("112");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетОтправкаJson() Экспорт
	
	Json = Новый Структура;
	Json.Вставить("Сотрудник", "Иванов Иван Петрович");
	Json.Вставить("Должность", "Разнорабочий");
	
	Результат = КоннекторHTTP.Post("http://httpbin.org/post", Неопределено, Json).Json();
	
	Ожидаем.Что(Результат["json"]["Сотрудник"]).Равно("Иванов Иван Петрович");
	Ожидаем.Что(Результат["json"]["Должность"]).Равно("Разнорабочий");
	
	Результат = КоннекторHTTP.Put("http://httpbin.org/put", Неопределено, Json).Json();

	Ожидаем.Что(Результат["json"]["Сотрудник"]).Равно("Иванов Иван Петрович");
	Ожидаем.Что(Результат["json"]["Должность"]).Равно("Разнорабочий");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетТаймаут() Экспорт
	
	ТекстОшибки = "";
	Попытка
		Ответ = КоннекторHTTP.Get("https://httpbin.org/delay/10", Неопределено, Новый Структура("Таймаут", 1));
	Исключение
		ТекстОшибки = ОписаниеОшибки();
	КонецПопытки;

	Ожидаем.Что(ТекстОшибки).Содержит("Время ожидания операции истекло");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетBasicAuth() Экспорт
	
	Результат = КоннекторHTTP.Get("http://user:pass@httpbin.org/basic-auth/user/pass").Json();

	Ожидаем.Что(Результат["authenticated"]).Равно(Истина);
	Ожидаем.Что(Результат["user"]).Равно("user");

	Аутентификация = Новый Структура("Пользователь, Пароль", "user", "pass");
	Результат = КоннекторHTTP.Get(
		"http://httpbin.org/basic-auth/user/pass",
		Неопределено,
		Новый Структура("Аутентификация", Аутентификация)).Json();

	Ожидаем.Что(Результат["authenticated"]).Равно(Истина);
	Ожидаем.Что(Результат["user"]).Равно("user");

	Аутентификация = Новый Структура("Пользователь, Пароль, Тип", "user", "pass", "Basic");
	Результат = КоннекторHTTP.Get(
		"http://httpbin.org/basic-auth/user/pass",
		Неопределено,
		Новый Структура("Аутентификация", Аутентификация)).Json();

	Ожидаем.Что(Результат["authenticated"]).Равно(Истина);
	Ожидаем.Что(Результат["user"]).Равно("user");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетDigestAuth() Экспорт
	
	Аутентификация = Новый Структура("Пользователь, Пароль, Тип", "user", "pass", "Digest");
	Результат = КоннекторHTTP.Get(
		"http://httpbin.org/digest-auth/auth/user/pass",
		Неопределено,
		Новый Структура("Аутентификация", Аутентификация)).Json();
	
	Ожидаем.Что(Результат["authenticated"]).Равно(Истина);
	Ожидаем.Что(Результат["user"]).Равно("user");
	
	Аутентификация = Новый Структура("Пользователь, Пароль, Тип", "guest", "guest", "Digest");
	Ответ = КоннекторHTTP.Get(
		"http://jigsaw.w3.org/HTTP/Digest/",
		Неопределено,
		Новый Структура("Аутентификация", Аутентификация));
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетРедиректСОтносительнымАдресом() Экспорт
	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/relative-redirect/6");
	Результат = Ответ.Json();
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.URL).Равно("http://httpbin.org/get");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетРедиректСАбсолютнымАдресом() Экспорт
	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/absolute-redirect/6");
	Результат = Ответ.Json();
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	Ожидаем.Что(Ответ.URL).Равно("http://httpbin.org/get");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетПрерываниеЗацикленногоРедиректа() Экспорт
	
	ТекстОшибки = "";
	Попытка
		Ответ = КоннекторHTTP.Get("http://httpbin.org/redirect/31");
	Исключение
		ТекстОшибки = ОписаниеОшибки();
	КонецПопытки;

	Ожидаем.Что(ТекстОшибки).Содержит("СлишкомМногоПеренаправлений");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетКодСостоянияИзОтвета() Экспорт
	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/status/404");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(404);

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетМетодOptions() Экспорт
	
	Ответ = КоннекторHTTP.Options("http://httpbin.org/anything");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетМетодHead() Экспорт
	
	Ответ = КоннекторHTTP.Head("http://httpbin.org/anything");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетМетодDelete() Экспорт
	
	Ответ = КоннекторHTTP.Delete("http://httpbin.org/delete");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетМетодPatch() Экспорт
	
	Ответ = КоннекторHTTP.Patch("http://httpbin.org/patch");
	
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетУстановкаCookies() Экспорт
	
	Результат = КоннекторHTTP.Get("http://httpbin.org/cookies/set/PHPSESSID/72a68cc1e55a4fbb9c0b8dbbeb49ca4f").Json();
	
	Ожидаем.Что(Результат["cookies"]["PHPSESSID"]).Равно("72a68cc1e55a4fbb9c0b8dbbeb49ca4f");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетОтправкаCookies() Экспорт
	
	Cookies = Новый Массив;
	Cookies.Добавить(Новый Структура("Наименование,Значение", "k1", Строка(Новый УникальныйИдентификатор)));
	Cookies.Добавить(Новый Структура("Наименование,Значение", "k2", Строка(Новый УникальныйИдентификатор)));
	Ответ = КоннекторHTTP.Get("http://httpbin.org/cookies", Неопределено, Новый Структура("Cookies", Cookies));
	Результат = Ответ.Json();
	
	Ожидаем.Что(Результат["cookies"]["k1"]).Равно(Cookies[0].Значение);
	Ожидаем.Что(Результат["cookies"]["k2"]).Равно(Cookies[1].Значение);

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетОтправкаФайла() Экспорт
	
	Файлы = Новый Структура;
	Файлы.Вставить("Имя", "f1");
	Файлы.Вставить("ИмяФайла", "file1.txt");
	Файлы.Вставить("Данные", Base64Значение("0J/RgNC40LLQtdGCINCc0LjRgCE="));
	Файлы.Вставить("Тип", "text/plain");
	
	Результат = КоннекторHTTP.Post(
		"https://httpbin.org/post",
		Неопределено,
		Неопределено,
		Новый Структура("Файлы", Файлы)).Json();
	
	Ожидаем.Что(Результат["files"]["f1"]).Равно("Привет Мир!");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоРаботаетОтправкаXMLСтрокой() Экспорт
	
	XML = 
	"<?xml version=""1.0"" encoding=""utf-8""?>
	|<soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
	|  <soap:Body>
	|    <GetCursOnDate xmlns=""http://web.cbr.ru/"">
	|      <On_date>2019-07-05</On_date>
	|    </GetCursOnDate>
	|  </soap:Body>
	|</soap:Envelope>";

	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Content-Type", "text/xml; charset=utf-8");
	Заголовки.Вставить("SOAPAction", "http://web.cbr.ru/GetCursOnDate");
	
	ДополнительныеПараметры = Новый Структура("Заголовки", Заголовки);
	Ответ = КоннекторHTTP.Post(
		"https://www.cbr.ru/DailyInfoWebServ/DailyInfo.asmx",
		XML,
		Неопределено,
		ДополнительныеПараметры);
	Ожидаем.Что(Ответ.Заголовки.Получить("Content-Type"), "text/xml; charset=utf-8");
	Ожидаем.Что(Ответ.КодСостояния).Равно(200);

КонецПроцедуры

Процедура ТестДолжен_ПроверитьПараметрыЗапросаТолькоКлюч() Экспорт

	Результат = КоннекторHTTP.Get("https://httpbin.org/get?key").Json();
	Ожидаем.Что(Результат["args"]["key"]).Равно("");

КонецПроцедуры

Процедура Тест_СложныеПараметрыЗапроса() Экспорт

	Результат = КоннекторHTTP.Get(
		"https://httpbin.org/anything?jql=worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01&j&i=2").Json();
	
	Ожидаем.Что(Результат["args"]["jql"]).Равно("worklogDate >= 2017-04-01 AND worklogDate <= 2017-05-01");
	Ожидаем.Что(Результат["args"]["j"]).Равно("");
	Ожидаем.Что(Результат["args"]["i"]).Равно("2");

КонецПроцедуры
