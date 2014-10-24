> # Sistemas y Tecnologías Web 2014-2015

![](http://cdn.them.pro/files/images/url.preview.jpg)
## Práctica 4 - STW-UrlShortener
================

### Objetivo

El objetivo de esta práctica es implementar una aplicación web, para acortar URL. Si el usuario está autenticado se guardaran todas sus URL's en una base de datos, y tendrá la opción de poder verlas. Esta aplicación la pondremos en la plataforma de [Heroku](https://www.heroku.com/).

- - - - - - -
#### Estructura de la aplicación
```
├── app.rb
├── config
│   ├── config_temaplate.yml
├── config.ru
├── Gemfile
├── Gemfile.lock
├── model.rb
├── Procfile
├── public
│   ├── css
│   │   ├── bootstrap.css
│   │   ├── bootstrap.min.css
│   │   ├── estilo.css
│   │   └── landing-page.css
│   ├── images
│   │   ├── bg.jpg
│   │   ├── google.png
│   │   └── logo.png
│   └── js
│       ├── bootstrap.js
│       └── bootstrap.min.js
├── Rakefile
├── README.md
├── test
│   └── test.rb
└── views
    ├── edit.haml
    ├── index.haml
    ├── layout.haml
    ├── oauth.haml
    └── show.erb

```

- - -
- - -
#### Ramas

El repositorio está divido en varias ramas, para facilitar el desarrollo de la aplicación:

- *Master* es la rama principal de la aplicación, donde está todo el código de la aplicación de la última versión. Vendría a ser nuestra rama *release*.

- *Development* se usa para desarrollar nuevas funcionalidades para la aplicación, es decir versión inestable, sin necesidad de tocar el código que hay en master, para que dicho código permanezca sin cambios hasta que éstos sean definitivos.

- *Production*, es la rama con el código que está puesto en producción en [Heroku](http://afternoon-earth-6699.herokuapp.com/).

- En Proceso ... (*gh-pages* contiene la documentación online de la aplicación. [Gh-Pages](http://alu0100537017.github.io/STW_Practica2_TestingSinatra/).)

#### Modo de empleo **manual**

Si se desea se puede descargar desde la rama master la aplicación para probarla en local, verla o modificarla al gusto de cada uno. Solo tiene que hacer:

`$ git clone https://github.com/alu0100537017/STW-UrlShortened.git

Una vez descargada la aplicación

- Haremos un `$ rake install` o un  `$ bundle install`, como se prefiera, para que instale las gemas de las que depende la aplicación para funcionar.
- Para correr la aplicación `$ ruby app.rb`
- Iremos al puerto **localhost:4567** en nuestro navegador y ya podremos interactuar con la aplicación.
- Para ejecutar los test tendremos que poner rake test.

###Autores

- Víctor Juidías Rodríguez - alu0100537017
- Débora Martín-Pinillos Brito- alu0100537154

Para más información

* [DataMapper](http://datamapper.org/getting-started.html)
* [Haml](http://haml.info/)
* [Sinatra](http://www.sinatrarb.com/)
* [Deploying Rack-based Apps in Heroku](https://devcenter.heroku.com/articles/rack)
* [Intridea Omniauth](https://github.com/intridea/omniauth)

