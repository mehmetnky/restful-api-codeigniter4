# Codeigniter4 RestfulAPI
This RestfulAPI was developed by me to be used for a football themed project. Now It's completely free to use, edit and manipulate by **anyone** with **any purpose**!
## Features
- Authentication with **JWT**
- Login and register endpoints
- Ready and free to edit & use!
## How to Use
Clone the repo and edit your apache server's `httpd.conf` and `httpd-vhosts.conf` files
### httpd.conf
    ...
    DocumentRoot "C:\{PROJECT_ROOT}\public"
    <Directory "C:\{PROJECT_ROOT}\public/">
    ...
### httpd-vhosts.conf
    ...
    DocumentRoot "C:\{PROJECT_ROOT}\public"
    <Directory "C:\{PROJECT_ROOT}\public/">
    ...
Then restart your apache server to apply new configs. Navigate to http://localhost:80/. If the response is `{"success":true}` you are ready to go! (Please don't forget to create database with the `db.sql` file)
## Endpoints
| # | endpoint |  method |  headers |  body |
|--|--|--|--|--|
| 1 | / | GET | - | - |
| 2 | /login | POST | - | {"email":"{email}","sifre":"{password}"} |
| 3 | /register | POST | - | {"email":"test@test.com","sifre":"123456","ad":"Test","soyad":"Oyuncu","foto":"asd.png","dogum_gunu":"1996-11-06","forma_numarasi":10,"mevki_id":1,"forma_beden_id":2,boy":172,"kilo":63,"ayakkabi_numarasi":41,"ayak":"Sağ"} |
| 4 | /players | GET | Authorization: Bearer ACCESS_TOKEN | - |
| 5 | /players/:id | GET | Authorization: Bearer ACCESS_TOKEN | - |
| 6 | /teams | GET | Authorization: Bearer ACCESS_TOKEN | - |
| 7 | /teams/:id | GET | Authorization: Bearer ACCESS_TOKEN | - |
| 8 | /players/byTeam/:id | GET | Authorization: Bearer ACCESS_TOKEN | - |

