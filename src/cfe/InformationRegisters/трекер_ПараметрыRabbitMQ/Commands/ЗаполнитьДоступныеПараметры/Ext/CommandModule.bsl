﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ЗаполнитьДоступныеПараметрыНаСервере();
	
КонецПроцедуры

Процедура ЗаполнитьДоступныеПараметрыНаСервере()
	РегистрыСведений.трекер_ПараметрыRabbitMQ.ЗаполнитьДоступныеПараметры();
КонецПроцедуры
