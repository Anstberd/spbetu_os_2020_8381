# Весенний курс по дисциплине "Операционные системы" 2020, группа 8381

## Таблица сдачи и приема работ студентов

| FirstName            | GitHub-аккаунт    | lab1  | lab2  | lab3  | lab4  | lab5  | lab6  | lab7  |
| -------------------- | ----------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Сахаров Виктор       | caxapexac         | 21.03 |       |       |       |       |       |       |
| Гречко Вероника      | LemonGrace        |       |       |       |       |       |       |       |
| Звегинцева Елизавета | Elli-zveg         |       |       |       |       |       |       |       |
| Муковский Данил      | garet2gis         |       |       |       |       |       |       |       |
| Облизанов Александр  | the21composer     | 02.03 | 11.03 | 28.03 |       |       |       |       |
| Ивлева Олеся         | olesy             | 11.03 | 11.03 |       |       |       |       |       |
| Гоголев Евгений      | StavrWalker       |       |       |       |       |       |       |       |
| Перелыгин Дмитрий    | Fireralin         |       |       |       |       |       |       |       |
| Почаев Никита        | Nik-Poch          | 02.03 | 11.03 |       |       |       |       |       |
| Нгуен Ши Хай         | NguyenHai-LETI    |       |       |       |       |       |       |       |
| Переверзев Дмитрий   | Dmitriy129        |       |       |       |       |       |       |       |
| Киреев Константин    | GandhiKK          | 11.03 | 28.03 |       |       |       |       |       |
| Сергеев Александр    | milesartemius     |       |       |       |       |       |       |       |
| Бердникова Анастасия | Anstberd          |       |       |       |       |       |       |       |
| Лисок Мария          | marilisok         | 11.03 |       |       |       |       |       |       |
| Сосновский Дмитрий   | DmitriySosnovskiy |       |       |       |       |       |       |       |

### Легенда

- \- - не сдано
- ~ - требуются исправления
- 01.03 - работа сдана, дата принятия работы
- ?! - другое, срочно требующее внимания

## Правила работы с репозиторием

- Для начала работы каждый студент делает форк (fork) репозитория на свой GitHub аккаунт.
- Каждый студент работает строго в своей директории firstname/ , где firstname - название директории в соотвтествии с вашей фамилией в таблицей, начинающаяся со строчой буквы. Работа в чужих директориях строго-настрого запрещается.

> Как сделать так, чтобы этого не произошло? Не надо синхронизировать свой репозиторий с master-веткой origin-репозитория. Не надо делать fetch-и с origin-репозитория или тем более fork-ов ваших коллег. Сделали один раз fork -- с ним и работаете, в своей директории. На надо удалять никаких файлов: ни чужих, ни своих с других веток, например. Не надо выполнять merge своих веток лишний раз, ибо это просто излишне. Работаете вы в отдельных ветках для каждой из лабораторных. Все это -- настоятельные советы, которые должны нивелировать возможность конфликтов при работе. Большая просьба их соблюдать, уважая время и труд ваших коллег.

- Для каждой лабораторной требуется создавать отдельную директорию lab#, где # - номер лабораторной от 1 до 7.

    Пример устройства корневой директории курса:
```
.
├── efremov
│   ├── lab1
│   │   ├── report.pdf
│   │   ├── source.asm
│   │   └── bin.com
│   └── lab2
│       ├── report.pdf
│       ├── source.asm
│       └── bin.exe
├── ivanova
│   ├── lab1
│   │   ├── report.pdf
│   │   ├── source.asm
│   │   └── bin.com
│   └── lab2
│       ├── report.pdf
│       ├── source.asm
│       └── bin.exe
└── README.md
```

- Внутри должны находиться:
    * Исходный код лабораторных программ;
    * Скомпилированные и скомпонованные исполняемые модули;
    * Отчет в формате pdf  **по шаблону с вузовского сайта**. Отчеты, оформленные иначе приниматься **не будут**. Не тратьте наше общее время.

> На всякий случай, каковы требования к оформлению: 14й шрифт Times New Roman (или похожий, например, свободный шрифты Linux Libertine или  Liberation Serif), 1.5 строки интервал, красная строка; заголовки должны иметься для каждого из разделов докумета, имеют такой же 14pt шрифт, выделяются жирным; обязательные разделы: цель работы, ход выполнения, ответы на вопросы (пожалуйста, пишите сами формулировки вопросов перед ответами!), выводы; копирование текста методички в отчет вовсе не требуется; все изображения и листинги должны быть информативные (пример неинформативного скриншота: *скриншот всего рабочего стола с открытым FAR-ом посреди какого-то представления исполняемого модуля*. Как сделать информативнее: уменьшить размер изображения до тех размеров, в которые помещается ровно тот участок представления, который что-то отображает (например, границу PSP), подчеркнуть, выделить требуемый участок изображения) пронумерованы и подписаны тем же 14pt обычным шрифтом, выровненным по центру (Пример: *Рисунок 2 -- Представление сегмента стека в памяти.*), на рисунок, раз уж вы его представили, вы где-то должны ссылаться (иначе зачем он нужен вообще?). Страницы нумеруются в нижней части документа, по центру (если используете шаблон с сайта вуза, все уже сделано за вас). Пожалуйста, соблюдайте эти не сложные требования к оформлению: их так гораздо проще как писать (имеется четкая структура, все эти требования по-умолчанию уже есть в вузовском шаблоне), так и проверять.

- Для каждой лабораторной создается **отдельная новая ветка (branch) из master-ветви** с названием вида < firstname\_lab# >, где firstname - фамилия (аналогично названию вашей личной директории), а # - номер работы, тоже со строчной буквы). Пример создания ветви и перехода на нее:

```
git checkout master
git checkout -b efremov_lab1
```
- Для сдачи лабораторной работы создается пул-реквест (pull-request) из вашей ветки с лабораторной работой в master-ветку общего репозитория курса. В начале заголовка пул-реквеста пишется "[READY] ", после - Фамилия латиницей, после - lab#. (Пример: *[READY] Efremov lab1*). Формат важен, так как для разбора ваших pull request используется поиск по ключевым словам.
- Для сдачи работы требуется закрытый pull request со слиянием (merge) вашей ветки в общий репозиторий. В таком случае работа считается **проверенной**.
- Если имеются какие-либо нарекания к предложенным студентом файлам, то все замечания пишутся проверяющим в комментарии пул-реквеста, а так же изменяется префикс заголовка на [WIP].
- Напоминание: коммиты в ветку, которую студент отправляет на пул-реквест отображаются в самом пул-реквесте. **Делать новый пул-реквест не надо.**
- Закончив исправления, студент пишет об этом отдельным комментарием, указывая, возможно, пояснения к исправлениям, а так же меняет префикс заголовка пул-реквеста снова на [READY], тем самым показывая, что его работа готова к повторному просмотру.
- Курс лабораторных считается завершенным полностью, если в основном репозитории находятся директории всех 7 лабораторных работ студента.

Ну и напоследок: делайте работы сами, пишите свой код. Работы прошлых курсов кишат ошибками и неточностями, а одинаковый код (порой, вплоть до хэша файлов исходного кода!) очень просто выявляется. В случае обнаружения, я попрошу вас, со ссылкой на первоисточник, заняться написанием своего решения. Поверьте, это все видно и выясняется просто: по самому коду, по ответам на вопросы.

Успехов.
