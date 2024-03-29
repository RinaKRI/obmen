﻿
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда	
		Возврат;	
	КонецЕсли;
	
	НужноРегистрировать = Истина;
	
	Если Не ЭтоНовый() И Не ЕстьИзменения() Тогда 
		НужноРегистрировать = Ложь;
	КонецЕсли;
	
	Если НужноРегистрировать Тогда
		ЗарегистрироватьКОбмену();
	КонецЕсли;
	
КонецПроцедуры

Функция ЕстьИзменения()

	Если ЭтоНовый() Тогда 
		Возврат Ложь;	 
	КонецЕсли; 
	
	ОбъектДоЗаписи = Ссылка.ПолучитьОбъект();
	
	Если ТипНомера <> ОбъектДоЗаписи.ТипНомера
		ИЛИ ДатаЗаезда <> ОбъектДоЗаписи.ДатаЗаезда
		ИЛИ ДатаВыезда <> ОбъектДоЗаписи.ДатаВыезда
       	ИЛИ НачалоДня(Дата) <> НачалоДня(ОбъектДоЗаписи.Дата) Тогда
		
		Возврат Истина;	
	КонецЕсли; 
	
	Если Постояльцы.Количество() <> ОбъектДоЗаписи.Постояльцы.Количество() Тогда
		Возврат Истина;	
	КонецЕсли;
	
	Для Сч = 0 По Постояльцы.Количество() - 1 Цикл
		Если Постояльцы[Сч].Постоялец <> ОбъектДоЗаписи.Постояльцы[Сч].Постоялец Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;

КонецФункции

Процедура ЗарегистрироватьКОбмену()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ОбменМеждуСистемамиБронирования.Ссылка КАК Ссылка
	               |ИЗ
	               |	ПланОбмена.ОбменМеждуСистемамиБронирования КАК ОбменМеждуСистемамиБронирования
	               |ГДЕ
	               |	НЕ ОбменМеждуСистемамиБронирования.ЭтотУзел
	               |	И НЕ ОбменМеждуСистемамиБронирования.ПометкаУдаления";

	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл  
			
		ОбменДанными.Получатели.Добавить(Выборка.Ссылка);
	
	КонецЦикла;

КонецПроцедуры



