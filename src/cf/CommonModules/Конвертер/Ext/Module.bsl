﻿
#Область ПрограммныйИнтерфейс

Функция ОбъектВТекстСообщения(Объект, ПараметрыДляТранспортера = Неопределено) Экспорт
	ТипДанных = ТипДанныхПоОбъекту(Объект);
	Если НЕ ЗначениеЗаполнено(ТипДанных) Тогда
		Возврат Неопределено;
	КонецЕсли;
	ДанныеОбъекта = Вычислить(СтрШаблон("ОбъектВДанныеОбъекта_%1(Объект)", ТипДанных)); 
	Если ПараметрыДляТранспортера <> Неопределено Тогда
		ПараметрыДляТранспортера.Вставить("ТипДанных", ТипДанных);
	КонецЕсли;
	Возврат ДанныеВТекстСообщения(ТипДанных, ДанныеОбъекта);
КонецФункции

Процедура ПреобразоватьТекстСообщенияВОбъект(ТекстСообщения) Экспорт
	ДанныеСообщения = ТекстСообщенияВДанныеСообщения(ТекстСообщения);
	ИмяМетода = СтрШаблон("ПреобразоватьДанныеОбъектаВОбъект_%1(ДанныеСообщения.Данные);", ДанныеСообщения.ТипОбъекта);
	Выполнить(ИмяМетода);
КонецПроцедуры

#КонецОбласти

#Область СлужбеныеПроцедурыИФункции

Функция ТипДанныхПоОбъекту(Объект)
	Соответствие = Новый Соответствие;
	Соответствие.Вставить(Тип("СправочникОбъект.ПрограммныеПродукты"), "ПрограммныйПродукт");
	Возврат Соответствие.Получить(ТипЗнч(Объект));
КонецФункции

Функция ДанныеВТекстСообщения(ТипОбъекта, Данные)
	ОписаниеТипа = Новый Структура;
	ОписаниеТипа.Вставить("ТипОбъекта", ТипОбъекта);
	ОписаниеТипа.Вставить("Данные", Данные);
	ТекстСообщения = КоннекторHTTP.ОбъектВJson(ОписаниеТипа);
	Возврат ТекстСообщения;
КонецФункции

Функция ОписаниеДанныхТипа(ТипОбъекта)
	ОписаниеТипа = Вычислить(СтрШаблон("ОписаниеДанныхТипа_%1()", ТипОбъекта));
	Возврат ОписаниеТипа;
КонецФункции

Функция ТекстСообщенияВДанныеСообщения(ТекстСообщения)
	ДанныеСообщения = КоннекторHTTP.JsonВОбъект(ТекстСообщения,, Новый Структура("ПрочитатьВСоответствие", Ложь));
	ТипОбъекта = ДанныеСообщения.ТипОбъекта;
	ДанныеОбъектаИзСообщения = ДанныеСообщения.Данные;
	ДанныеОбъекта = ОписаниеДанныхТипа(ТипОбъекта);
	ЗаполнитьЗначенияСвойств(ДанныеОбъекта, ДанныеОбъектаИзСообщения);
	ДанныеСообщения.Вставить("Данные", ДанныеОбъекта);
	Возврат ДанныеСообщения;
КонецФункции

#Область ЗаявкаНаИзменение

Функция ОписаниеДанныхТипа_ЗаявкаНаИзменение()
	ОписаниеТипа = Новый Структура;
	ОписаниеТипа.Вставить("Заказчик");
	ОписаниеТипа.Вставить("ПрограммныйПродукт");
	ОписаниеТипа.Вставить("ПервичноеОбращение");
	
	Возврат ОписаниеТипа;
КонецФункции

Процедура ПреобразоватьДанныеОбъектаВОбъект_ЗаявкаНаИзменение(ДанныеОбъекта)
	ОписаниеЗаявки = БизнесПроцессы.ЗаявкаНаИзменение.НовоеОписаниеЗаявки(
		ДанныеОбъекта.Заказчик,
		ДанныеОбъекта.ПрограммныйПродукт,
		ДанныеОбъекта.ПервичноеОбращение);
	БизнесПроцессы.ЗаявкаНаИзменение.СоздатьИСтартовать(ОписаниеЗаявки);
КонецПроцедуры

#КонецОбласти

#Область ПрограммныйПродукт

Функция ОписаниеДанныхТипа_ПрограммныйПродукт()
	ОписаниеТипа = Новый Структура;
	ОписаниеТипа.Вставить("Ссылка");
	ОписаниеТипа.Вставить("Наименование");
	ОписаниеТипа.Вставить("Имя");
	
	Возврат ОписаниеТипа;
КонецФункции

Функция ОбъектВДанныеОбъекта_ПрограммныйПродукт(Объект)
	ДанныеОбъекта = ОписаниеДанныхТипа_ПрограммныйПродукт();
	ЗаполнитьЗначенияСвойств(ДанныеОбъекта, Объект);
	ДанныеОбъекта.Ссылка = Строка(Объект.Ссылка.УникальныйИдентификатор());
	Возврат ДанныеОбъекта;
КонецФункции

Процедура ПреобразоватьДанныеОбъектаВОбъект_ПрограммныйПродукт(ДанныеОбъекта)
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
