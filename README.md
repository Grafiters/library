# Library Project
Library project is just for data collection but with relation author, using *MVC* concept, and have 1 endpoint *api* to generate response as json

## Specification
- ruby version -> *3.0.6*, specific in file *.ruby-version*, can change with another version
- bundler
- rails version -> *7.0.8*, specific in file *Gemfile*, can change with another version
- redis
- database -> pgsql
- smtp

## How to setup
before run the project the specification must completed, follow the step to setup the project :

### Install specification
- Ruby
    
    Ruby version on this project using version `3.0.5`, following installation step on [ruby installation step](https://gorails.com/setup/ubuntu/22.04)

- Bundler

    Bundle version to running project using version `2.2.33`

- Rails

    Rails version itself on this project using version `7.0.6`, following installation steps on [rails installation step](https://gorails.com/setup/ubuntu/22.04)

- Database

    Database system on this project using `postgis` beacuse that is requirement to using geometry location system with gem postgis adapter can using any version of postgis, for installation postgis you can run 

    ! when using docker and docker-compose !
    ```sh
    $ docker-compose up -Vd dbpgsql
    ```
    that command will be running script `.yml` if using docker or follow installation step on [postgis documentation](https://postgis.net/documentation/getting_started/)

- redis

    Redis requirement to running the sidekiq ascync delayed job, for installation postgis you can run 

    ! when using docker and docker-compose !
    ```sh
    $ docker-compose up -Vd redis
    ```
    that command will be running script `.yml` if using docker or follow installation step on [postgis documentation](https://postgis.net/documentation/getting_started/)

- SMTP

    SMTP is requirement to sending email notifier, you can use smtp project thrid party like *mailgun* or *smtp2go*

### Install project
after installation spesificatio setup is installed you can follow the step of installation project:

1. clone project   
    ```bash
    $ git clone https://github.com/Grafiters/library
    ```

2. install depedencies on gemfile
    ```bash
    $ bundle install
    ```

3. setup the environment
    - copy the file *.env.example* to *env*
    - change all variable in file *.env* with specification have you installed

4. seed database project
    when database not installed you can install database via docker with running this command
    ```bash
    $ docker-compose up -Vd
    ```

    ```bash
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed
    ```

5. running project
    ```bash
    $ rails s //for running project server
    $ bundle exec sidekiq //for running sidekiq server
    ```

    when project is running you can access the admin panel by access url on browser *http://localhost:3000* and for dashboard of sidekiq you can access on url *http://localhost:3000/sidekiq*

6. endpoint
    
    this project only have 1 endpoint that is `/api/v2/books`, more over is handle with Controller Views

    to get data from endpoint `/api/v2/books` you can using filtered params like this :
    ```json
    /api/v2/book
    params: {
        "limit": <integer>,
        "page": <integer>,
        "type_book": "String",
        "author_uid": "String",
        "title": "String",
        "tgl_publish": <timestamp integer>,
        "tgl_publish_start": <timestamp integer>,
        "tgl_publish_end": <timestamp integer>,
        "uid": "String"
    }
    ```

7. Unit Test

    Unit testing is using rspec by running this command :
    ```bash
    $ bundle exec rspec
    ```