﻿#Область ПрограммныйИнтерфейс

Процедура ЗагрузитьСообщения(ОбъектКонвертер) Экспорт
	КоличествоЗаявок = 0;
	Кэш = Неопределено;
	
	Очереди = ОчередиДляПолученияСообщений();
	Для Каждого Очередь Из Очереди Цикл
		Пока Истина Цикл
			ТекстСообщения = ПолучитьСообщение(Очередь, Кэш);
			Если ТекстСообщения <> Неопределено Тогда
				ОбъектКонвертер.ПреобразоватьТекстСообщенияВОбъект(ТекстСообщения);
				КоличествоЗаявок = КоличествоЗаявок + 1;
			Иначе
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Сообщить(СтрШаблон("Загружено заявок на изменение: %1", КоличествоЗаявок));
КонецПроцедуры

Процедура СформироватьИОтправитьСообщение(Объект, ОбъектКонвертер) Экспорт
	ВспомогательныеПараметры = Новый Структура;
	ТекстСообщения = ОбъектКонвертер.ОбъектВТекстСообщения(Объект, ВспомогательныеПараметры);
	Если ТекстСообщения = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	ОтправитьСообщение(ТекстСообщения, ВспомогательныеПараметры);
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОтправитьСообщение(ТекстСообщения, ДополнительныеПараметры) Экспорт
	КлючАналитики = ДополнительныеПараметры.ТипДанных;
	
	ПараметрыСообщения = трекер_RabbitMQКлиентСервер.НовыеПараметрыИсходящегоСообщения();
	ПараметрыПодключения = РегистрыСведений.трекер_ПараметрыRabbitMQ.ЗначенияПараметров();
	ЗаполнитьЗначенияСвойств(ПараметрыСообщения, ПараметрыПодключения);
	ПараметрыСообщения.КлючМаршрутизации = ПараметрыПодключения.КлючМаршрутизации[КлючАналитики];
	
	ПараметрыСообщения.ТекстСообщения = ТекстСообщения;
	
	КлиентКомпоненты = ПолучитьКомпоненту();
	трекер_RabbitMQКлиентСервер.ОтправитьСообщение(КлиентКомпоненты, ПараметрыСообщения);
КонецПроцедуры

Функция ПолучитьСообщение(ИмяОчереди, КэшируемыеЗначения = Неопределено) Экспорт
	Если КэшируемыеЗначения = Неопределено Тогда
		КэшируемыеЗначения = Новый Структура;
	КонецЕсли;
	
	ПараметрыСообщения = трекер_ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(КэшируемыеЗначения, "ПараметрыСообщения");
	Если ПараметрыСообщения = Неопределено Тогда
		ПараметрыСообщения = трекер_RabbitMQКлиентСервер.НовыеПараметрыВходящегоСообщения();
		ПараметрыПодключения = РегистрыСведений.трекер_ПараметрыRabbitMQ.ЗначенияПараметров();
		ЗаполнитьЗначенияСвойств(ПараметрыСообщения, ПараметрыПодключения);
		КэшируемыеЗначения.Вставить("ПараметрыСообщения", ПараметрыСообщения);
	КонецЕсли;
	ПараметрыСообщения.ИмяОчереди = ИмяОчереди;
	КлиентКомпоненты = трекер_ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(КэшируемыеЗначения, "КлиентКомпоненты");
	Если КлиентКомпоненты = Неопределено Тогда
		КлиентКомпоненты = ПолучитьКомпоненту();
		КэшируемыеЗначения.Вставить("КлиентКомпоненты", КлиентКомпоненты);
	КонецЕсли;
	
	Сообщение = трекер_RabbitMQКлиентСервер.ПрочитатьСообщение(КлиентКомпоненты, ПараметрыСообщения);
	Возврат Сообщение;
КонецФункции

Функция ОчередиДляПолученияСообщений()
	ЗначенияПараметров = РегистрыСведений.трекер_ПараметрыRabbitMQ.ЗначенияПараметров();
	Если ТипЗнч(ЗначенияПараметров.ИмяОчереди) = Тип("Массив") Тогда
		Очереди = ЗначенияПараметров.ИмяОчереди; 
	Иначе
		Очереди = трекер_ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ЗначенияПараметров.ИмяОчереди); 
	КонецЕсли;
	Возврат Очереди;
КонецФункции

Функция ПолучитьКомпоненту() Экспорт
	
	КлиентКомпоненты = Неопределено;
	Если Не трекер_RabbitMQКлиентСервер.ИнициализироватьКомпоненту(КлиентКомпоненты) Тогда
		
		ПодключитьКомпоненту();
		трекер_RabbitMQКлиентСервер.ИнициализироватьКомпоненту(КлиентКомпоненты);
		
	КонецЕсли;
	
	Возврат КлиентКомпоненты;
КонецФункции

Функция ПолучитьАдресМакетаКомпановки(УникальныйИдентификатор) Экспорт
	
	МакетВнешнейКомпоненты    = Обработки.трекер_ПримерРаботыСКомпонентойPinkRabbitMQ.ПолучитьМакет("ВнешняяКомпонента");
	АдресВоВременномХранилище = ПоместитьВоВременноеХранилище(МакетВнешнейКомпоненты, УникальныйИдентификатор);
	
	Возврат АдресВоВременномХранилище;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПодключитьКомпоненту(КомпонентаПодключена = Неопределено, ВыводитьСообщения = Ложь)
	
	АдресВоВременномХранилище = ПолучитьАдресМакетаКомпановки(Новый УникальныйИдентификатор);
	КомпонентаПодключена = ПодключитьВнешнююКомпоненту(
			АдресВоВременномХранилище,
			"BITERP",
			ТипВнешнейКомпоненты.Native);
	Если ВыводитьСообщения Тогда
		Сообщить(НСтр("ru = 'Компонента подключена!'"));
	КонецЕсли;	
КонецПроцедуры

#КонецОбласти