﻿
Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	Если ВидФормы = "ФормаОбъекта" И ЗначениеЗаполнено(Параметры.Ключ) Тогда
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗадачаИсполнителя.Ссылка КАК Ссылка
		|ИЗ
		|	Задача.ЗадачаИсполнителя КАК ЗадачаИсполнителя
		|ГДЕ
		|	ЗадачаИсполнителя.Ссылка = &Ссылка
		|	И ЗадачаИсполнителя.Выполнена";
		
		Запрос.УстановитьПараметр("Ссылка", Параметры.Ключ);
		
		Результат = Запрос.Выполнить();
		Если Результат.Пустой() Тогда
			СтандартнаяОбработка = Ложь;
			Параметры.Вставить("ЗадачаИсполнителя", Параметры.Ключ);
			Параметры.Вставить("Ключ", Параметры.Ключ.БизнесПроцесс);
			ВыбраннаяФорма = Метаданные.БизнесПроцессы.ЗаявкаНаИзменение.Формы.ФормаБизнесПроцесса;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры
