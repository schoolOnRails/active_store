# Active Store 👋

Привет! Перед нами стоит задача на написание удобной библиотеки на создание классов моеделей аля Active Record

## Стэк 🍿

- Ruby 3

## Что есть на данный момент🧙

При создании и наследовании BaseModel при такой структуре
```
class User < ActiveStore::BaseModel
  attributes id: Integer, name: String, age: Integer
end
```
Мы получаем на выходе:
1. Готовый класс, который создаёт accessor и ждёт в initialize параметры, указаные в attributes schema (id, name, age)
2. Валидация данных attributes schema и строгая валидация по количеству заданых параметров
3. Методы с active record, такие как: all, create, update, delete, find_by, clear_store
4. Вспомогательный метод to_h для выхода данных в json Формате

## Таски 👩‍💻
AS1 Добавление интеграции с Postgresql (должно быть опционально к использованию)
AS2 Добавление Dry::Types интеграции (должно быть опционально к использованию)
AS3 Возможность менять названия полей (id, name, string) так же меняются и поля DB
AS4 Создание schema file который можно передать и создать сразу необходимые классы с полями, ниже пример:

```
file.rb
___

"User": {
  "id": String,
  "name": String
   ...
}
```
