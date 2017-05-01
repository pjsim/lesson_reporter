# Lesson Reporter Challenge

### Description

An app for observing and updating the progress of students as they complete 100 lessons divided into 3 parts each.
Teachers can also be added to the system and have their own students assigned underneath them.

### Layout

This rails app is divided into two main sections; one for students and one for teachers.

The students section shows a table of students, their progression in the lessons and action buttons to
* see the student's information in JSON format or to update their progress.
* update their progress in the lessons.

The teachers section is similar but instead shows a table of teachers and a 'Report' button, which when clicked, shows a table of students filtered for that teacher.

In this view teachers can 
* also view a student's information in JSON
* use the 'Advance' button to quickly progress a student to the next lesson without needing a form.

### To get started

```shell
bundle install
rake db:setup
rails s
```

The app can then be viewed through [localhost:3000](http://localhost:3000) and all tests can be run with the `rspec` command

More students and teachers can be seeded with `rake db:seed` if desired

### Versions

* ruby - 2.4.0p0
* rails - 5.0.2
