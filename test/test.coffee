assert          = require 'assert'
request         = require 'supertest'
should          = require 'should'

url = 'http://localhost:80'

describe 'Express controllers', () ->
    describe '/books/', () ->
        it 'should return a list of books', (done) ->
            request(url)
                .get '/books'
                .expect 'Content-Type', /json/
                .expect 200
                .end (err, res) =>
                    if err? 
                        throw err
                    res.body.should.be.a.Array
                    res.body.should.matchEach (book) ->
                        book.should.have.properties ['isbn', 'title', 'price', 'cover']
                    return done()

    describe '/cart/get_offer', () ->
        it 'should return an error because cart is empty', (done) ->
            request(url)
                .get '/cart/get_offer'
                .expect 'Content-Type', /json/
                .expect 200
                .end (err, res) =>
                    if err? 
                        throw err
                    res.body.should.be.a.Object
                    res.body.should.have.properties ['name', 'message']
                    res.body.name.should.be.exactly 'EmptyCartError'
                    res.body.message.should.be.exactly 'Your cart is empty !'
                    return done()

    describe '/cart/get', () ->
        it 'should return an empty cart', (done) ->
            request(url)
                .get '/cart/get'
                .expect 'Content-Type', /json/
                .expect 200
                .end (err, res) =>
                    if err? 
                        throw err
                    res.body.should.not.exist
                    return done()

    describe '/cart/add_item', () ->
        it 'should add an item to the cart and return the correct cart', (done) ->
            request(url)
                .post '/cart/add_item'
                .type 'json'
                .send
                    isbn: 'c8fabf68-8374-48fe-a7ea-a00ccd07afff'
                    title: "Henri Potier à l'école des sorciers"
                    price: 35
                    cover: 'http://henri-potier.xebia.fr/hp0.jpg'
                .expect 'Content-Type', /json/
                .expect 200
                .end (err, res) =>
                    if err? 
                        throw err
                    res.body.should.be.a.Object
                    res.body.should.have.properties ['items', 'total_price']
                    res.body.items.should.be.a.Array
                    res.body.items.length.should.be.exactly 1
                    res.body.should.containDeep
                        items: [
                            isbn: 'c8fabf68-8374-48fe-a7ea-a00ccd07afff'
                            title: "Henri Potier à l'école des sorciers"
                            price: 35
                            cover: 'http://henri-potier.xebia.fr/hp0.jpg'
                            ]
                    res.body.total_price.should.be.exactly 35
                    return done()

    describe '/cart/add_item', () ->
        it 'should add a second item to the cart and return the correct cart', (done) ->
            request(url)
                .post '/cart/add_item'
                .type 'json'
                .send
                    isbn: 'a460afed-e5e7-4e39-a39d-c885c05db861'
                    title: "Henri Potier et la Chambre des secrets"
                    price: 30
                    cover: 'http://henri-potier.xebia.fr/hp1.jpg'
                .expect 'Content-Type', /json/
                .expect 200
                .end (err, res) =>
                    if err? 
                        throw err
                    res.body.should.be.a.Object
                    res.body.should.have.properties ['items', 'total_price']
                    res.body.items.should.be.a.Array
                    res.body.items.length.should.be.exactly 2
                    # It should contain second book
                    res.body.should.containDeep
                        items: [
                            isbn: 'a460afed-e5e7-4e39-a39d-c885c05db861'
                            title: "Henri Potier et la Chambre des secrets"
                            price: 30
                            cover: 'http://henri-potier.xebia.fr/hp1.jpg'
                            ]
                    # It should contain first book
                    res.body.should.containDeep
                        items: [
                            isbn: 'c8fabf68-8374-48fe-a7ea-a00ccd07afff'
                            title: "Henri Potier à l'école des sorciers"
                            price: 35
                            cover: 'http://henri-potier.xebia.fr/hp0.jpg'
                            ]
                    res.body.total_price.should.be.exactly 65
                    return done()

    describe '/cart/get_offer', () ->
        it 'should return an object containing a list of offers', (done) ->
            request(url)
                .get '/cart/get_offer'
                .expect 'Content-Type', /json/
                .expect 200
                .end (err, res) =>
                    if err? 
                        throw err
                    res.body.should.be.a.Object
                    res.body.should.have.properties ['final_price', 'value', 'type']
                    if res.body.type is 'slice'
                        res.body.should.have.property 'sliceValue'
                    return done()

    describe '/cart/remove_item', () ->
        it 'should remove the first item from the cart and return the correct cart', (done) ->
            request(url)
                .post '/cart/remove_item'
                .type 'json'
                .send
                    isbn: 'c8fabf68-8374-48fe-a7ea-a00ccd07afff'
                    title: "Henri Potier à l'école des sorciers"
                    price: 35
                    cover: 'http://henri-potier.xebia.fr/hp0.jpg'
                .expect 'Content-Type', /json/
                .expect 200
                .end (err, res) =>
                    if err? 
                        throw err
                    res.body.should.be.a.Object
                    res.body.should.have.properties ['items', 'total_price']
                    res.body.items.should.be.a.Array
                    res.body.items.length.should.be.exactly 1
                    # It should contain only second book
                    res.body.should.containDeep
                        items: [
                            isbn: 'a460afed-e5e7-4e39-a39d-c885c05db861'
                            title: "Henri Potier et la Chambre des secrets"
                            price: 30
                            cover: 'http://henri-potier.xebia.fr/hp1.jpg'
                            ]
                    res.body.total_price.should.be.exactly 30
                    return done()





