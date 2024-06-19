
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти



#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти



#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	//{19.06.2024 О.С. Исакова процедура для работы с согласованной скидкой
	ДО_РасчитатьСуммуНоменклатура(ТекущиеДанные);
	//}
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьТаблицу(Команда)
//{19.06.2024 О.С. Исакова процедура для работы с согласованной скидкой	
//проверяем заполненность табличной части;	
	Если Элементы.Товары.ТекущиеДанные <> Неопределено ИЛИ Элементы.Услуги.ТекущиеДанные <> Неопределено Тогда // если заполнена хотябы 1 ТЧ код будет работать
		ДО_ПрименитьСкидку(); //  надо создать процедуру, 
	КонецЕсли;
	
	// не забываем про расчет суммы документа
	РассчитатьСуммуДокумента(); 
КонецПроцедуры

&НаКлиенте
Процедура ДО_ПрименитьСкидку() // пересчитывает суммы после применения скидки
	
	Для Каждого Товар ИЗ Объект.Товары Цикл // объект.Товары обращение к ТЧ Товары
		ДО_РасчитатьСуммуНоменклатура(Товар);
	КонецЦикла; 
	
	Для Каждого Услуга ИЗ Объект.Услуги Цикл // объект.Услуги обращение к ТЧ Услуги
		ДО_РасчитатьСуммуНоменклатура(Услуга);

	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ДО_РасчитатьСуммуНоменклатура(Номенклатура) 
	
	ОбщаяСкидка = Объект.ДО_СогласованнаяСкидка + Номенклатура.Скидка;
	
	Если ОбщаяСкидка <= 100 Тогда
		Номенклатура.Сумма = Номенклатура.Цена * Номенклатура.Количество * (100 - ОбщаяСкидка) / 100; 
	Иначе
		Номенклатура.Сумма = 0;
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст ="Сумма скидок не может превышать 100%.";
		Сообщение.Сообщить();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДО_СогласованнаяСкидкаПриИзменении(Элемент)
	
		ДО_ЗадатьВопрос();
		
		РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ДО_ЗадатьВопрос()
	
	Режим = РежимДиалогаВопрос.ДаНет;
	Ответ = Ждать ВопросАсинх("Пересчитать стоимость согласно установленной скидке?", Режим);
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ДО_ПрименитьСкидку();
	ИначеЕсли  Ответ = КодВозвратаДиалога.Нет Тогда
	 	Возврат
	КонецЕсли; 
			
	РассчитатьСуммуДокумента();

КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
