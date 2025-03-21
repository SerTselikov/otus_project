﻿
// Создает массив и помещает в него переданное значение.
//
// Параметры:
//  Значение - Произвольный - любое значение.
//
// Возвращаемое значение:
//  Массив - массив из одного элемента.
//
Функция ЗначениеВМассиве(Знач Значение) Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить(Значение);
	Возврат Результат;
	
КонецФункции

// Возвращает значение свойства структуры.
//
// Параметры:
//   Структура - Структура
//             - ФиксированнаяСтруктура - объект, из которого необходимо прочитать значение ключа.
//   Ключ - Строка - имя свойства структуры, для которого необходимо прочитать значение.
//   ЗначениеПоУмолчанию - Произвольный - возвращается когда в структуре нет значения по указанному
//                                        ключу.
//       Для скорости рекомендуется передавать только быстро вычисляемые значения (например примитивные типы),
//       а инициализацию более тяжелых значений выполнять после проверки полученного значения (только если это
//       требуется).
//
// Возвращаемое значение:
//   Произвольный - значение свойства структуры. ЗначениеПоУмолчанию если в структуре нет указанного свойства.
//
Функция СвойствоСтруктуры(Структура, Ключ, ЗначениеПоУмолчанию = Неопределено) Экспорт
	
	Если Структура = Неопределено Тогда
		Возврат ЗначениеПоУмолчанию;
	КонецЕсли;
	
	Результат = ЗначениеПоУмолчанию;
	Если Структура.Свойство(Ключ, Результат) Тогда
		Возврат Результат;
	Иначе
		Возврат ЗначениеПоУмолчанию;
	КонецЕсли;
	
КонецФункции
