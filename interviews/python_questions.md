Python Questions
Как бывают типы данных?Mutable / immutable  переменные- неизменяемые: int, float, str, tuple, bool, NoneType, frozenset- изменяемые: list, set, dict
Чем отличается = и is?
= сравнивает хранящиеся значения, а is ссылки на объекты в памяти
Как передаются аргументы в функцию?
Неизменяемые типы передаются по значениям, изменяемые по ссылкам
Что такое args и kwargs?
	⁃	args: включает в себя беск число позиционных аргументов, представлен в виде tuple
	⁃	kwargs: беск число аргументов, заданных с пом ключевых слов, представлен в виде dict
Что такое глуб и поверх копирование? Разница? Зачем нужны? (copy, deepcopy)
	⁃	copy: делает копию только внешнего объекта (допустим списка), но не делает копию все внутренних переменных, если они есть. То есть при copy(list) списки будут разными, но объекты внутри списков - одни и те же.
	⁃	deepcopy: реккурсивно копирует все внутренние объекты 
Что такое аннотации типов? Когда они применяются?
Это подсказки к какому то аргументу, переменной (при создании класса, функций).
Пример: def func(x: int)
Не выполняются runtime. Ошибки не будет, если передадим др тип данных. Нужны для читаемости.
Что такое тернарный оператор? 
Это просто if-оператор, записанный в одну строку
Big O notation.
Алгоритмы принято оценивать с точки зрения его атомарных операций (не с т з времени)
что такое self в классах? что такое super?
класс - шаблон для создания каких то уникальных объектов (экземпляров класса)
- self: ссылка в методах объектов на текущий созданный объект (экземпляр класса). Чтобы понимать с каким объектом вз-м, откуда брать данные и тд
- super: - ссылка на объект родительской сущности. Требуется для доступа к родительский унаследованным классам. Часто используется в магических методах (__init__, repr и тд) для проброса родительского функционала
Разница и реализация методов объектов, методов класса и статических методов?
- методы объектов: классические методы классов, первый аргумент - self - ссылка на текущий объект. Характеризуют поведения отдельного экземпляра класса. Можно воспользоваться только после иниц-и объекта
- методы класса: создаются с помощью декоратора @classmethod. Первый аргумент - cls - ссылка на текущий класс. Характеризуют поведение всего класса. Создание объекта класса не требуется, вызывается сразу через класс
- статические методы: создаются с помощью декоратора @staticmethod. Не принадлежит ни классу, ни объекту. Хранится там исключительно из-за смысловой привязки. Создание экземпляра не требуется
Как в python реализуются public, private, protected методы и атрибуты?
В Python нет модификаторов доступа, все по умолчанию public. 
- protected атрибуты и методы видны в рамках текущего класса и в рамках дочернего класса, снаружи не видны. Для реализации в python принято создавать protected методы и аттрибуты: _func, arr (использовать можно, но не рекомендовано)
- private атрибуты доступны только в рамках используемого класса. Для реализации принято ставить два underscore (__value). При обращении к нему питон немного искажает его название, чтобы не получилось обратиться напрямую: <class_obj>.__value  - не пройдет, <class_obj>.<class_name>__value  - пройдет
Декораторы. Что это? Как реализовать проброс параметра?
это некий паттерн проектирования. Таким образом декоратор - функция, позволяющая обернуть др функцию для расширения ее функциональности без непосредственного изменения ее кода. Это достижимо, тк в python все является объектами, в тч и функции, т е мы можем передать одну функцию на вход другой. Можно применять непосредственно переопределяя декорированную функцию: func_new = decorator(func), а можно через синтаксический сахар: @decorator, а ниже определение функции func. Проброс параметров для func можно завернуть в args и kwargs:
def decorator(func):
    def wrapper(*args, **kwargs):
        print('before func')
        func(*args, **kwargs)
        print('after func')
    return wrapper
Для передачи параметров именно в декоратор:
def outer(a=1):
    def decorator(func): 
        def wrapper(*args, **kwargs): 
            print('before func')
func(*args, **kwargs) 
            print('after func') 
        return wrapper
    return decorator
Использование: 
@outer(a=999)
def new_func(...)
Абстрактные классы. Зачем нужны? Как реализуются в Python? 
Требуются для реализации контрактов (правил) между классов. 
Абс. класс - класс, у которого нельзя создать объект. Нужен для написания контракта (правила), который должны реализовать дочерние классы. Контракт пишется в виде абстрактных методов. 
from abc import ABC, abstractmethod # родитель для абс классаclass A(ABC): 
    @abstractmethod
    def func(...)
Класс Б(А) будет являться до тех пор абстрактным, пока мы не переопределим все абстрактные методы класса А.Итератор. Итерируемый объект. Генератор.
- итератор: любой объект, реализующий метод next, который возвращает следующий элемент в очереди или выбрасывает исключение StopIteration, если не осталось элементов. Цель итератора – пройтись по элементам. Для этого у него есть метод next, который возвращает элементы один за другим.
- итерируемый объект: любой объект, реализующий метод iter. Итерируемым объектом является любая коллекция: список, кортеж, словарь, и т.д. Цель итерируемого объекта – создать итератор. Для этого у него есть метод iter, при каждом обращении к которому создается новый итератор.Генератор – функция, которая генерирует значения runtime посредством yield. Она отличается от обычной функции тем, что может приостанавливать свое выполнение, возвращать промежуточный результат, а затем возобновлять выполнение в любой момент времени. Любой генератор является итератором
ООП. Основные принципы.
ООП - парадигма объектно-ориентированного программирования, при который код выстраивается в виде совокупности объектов, являющихся экземплярами каких то классов, выстраивающих иерархию какого то наследования.
- наследование: дочерний класс перенимает весь родительский функционал- инкапсуляция: понимается двояко. Фундаментально про то, что в класс помещаем атрибуты и методы, идейно связанные друг с другом (мы их инкапсулирем в класс и оттуда работаем с ними). С другой стороны этот принцип про сокрытие, то есть в классе должны превалировать приватные методы и атрибуты, а пользователю показываем только требуемый ему функционал.
- полиморфизм: нам нет разницы до типа входящего объекта, если в нем реализован требуемый нам функционал (параметрический полиморфизм)
- абстракция: в коде мы используем только те хар-ки объектов, которые нам важны в данном коде.Что такое Миксины?
Классы "примесей" с небольшим функционалом, требующийся во многих других классахЧто такое diamond problem? Что такое MRO?
Проблема связанная с ромбовидным (множественным) наследованием (классы А, B(А), C(А), D(B, C)). Фундаментальная проблема про то как проходить по конструкторам и искать нужные методы, атрибуты у родителей. В python3 есть решение MRO(method resolution ordering) - используется bfs (поиск в ширину - сначала все родители, потом все родители родителей и тд).
В каждом классе есть метод mro() - список для поиска по родительским классом (получен через bfs)Async. Await.
3 основные либы - threading, multiprocessing, asyncio
- threading: в рамках одного процесса делим потоки, у потоков есть общая память и они конкурентно выполняются 
- multiprocessing:  можем запускатьпрограмму в различных процессах, независящих друг от друга. Для выполнения нужна архитектура в виде минимум многоядерного процессора
- asyncioЧто такое GIL? Какие проблемы он решает?
Концепция GIL (Global Interpreter Lock) заключается в том, что в каждый момент времени только один поток может исполняться процессором. Это сделано для того, чтобы между потоками не было борьбы за отдельные переменные. Исполняемый поток получает доступ по всему окружению. Такая особенность реализации потоков в Python значительно упрощает работу с потоками и дает определенную потокобезопасность (thread safety)