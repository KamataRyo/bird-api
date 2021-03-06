frisby   = require 'frisby'
APIurl   = require('../utilities').getAPIurl

frisby
    .create 'bad request(1)'
    .get APIurl 'some_strange_directory'
    .expectStatus 404
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .toss()

frisby
    .create 'bad request(2)'
    .get APIurl 'some_strange_directory/not_acceptable'
    .expectStatus 404
    .toss()

frisby
    .create 'GET document, test of structure'
    .get APIurl ''
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes 'document',
            title: String
            links: Array
    .expectJSONTypes 'document.links.*',
            rel: String
            href: String
    .toss()

frisby
    .create 'GET birds'
    .get APIurl 'birds'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '', species: Array
    .expectJSONTypes 'species.*',
            sc: String
            ja: String
            alien: Boolean
            upper_id: String
    .expectJSON 'species.*', rank: 'species'
    .toss()


frisby
    .create 'GET birds with fields query'
    .get APIurl 'birds?fields=ja,rank'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '', species: Array
    .expectJSONTypes 'species.*',
            rank: String
            sc: undefined
            ja: String
            alien: undefined
            upper_id: undefined
    .toss()


frisby
    .create 'GET birds with limit query'
    .get APIurl 'birds?limit=20'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '', species: Array
    .expectJSONLength 'species', 20
    .toss()

frisby
    .create 'GET species with too many offset query'
    .get APIurl 'species?offset=100000000'
    .expectStatus 404
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .toss()


frisby
    .create 'GET genuses'
    .get APIurl 'genuses'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '', genuses: Array
    .expectJSONTypes 'genuses.*',
            sc: String
            ja: String
            upper_id: String
    .expectJSON 'genuses.*', rank: 'genus'
    .toss()


frisby
    .create 'GET families'
    .get APIurl 'families'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '', families: Array
    .expectJSONTypes 'families.*',
            sc: String
            ja: String
            upper_id: String
    .expectJSON 'families.*', rank: 'family'
    .toss()


frisby
    .create 'GET orders'
    .get APIurl 'orders'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '', orders: Array
    .expectJSONTypes 'orders.*',
            sc: String
            ja: String
    .expectJSON 'orders.*', rank: 'order'
    .toss()


frisby
    .create 'GET birds/スズメ'
    .get APIurl 'birds/スズメ'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            name: Object
            binomen: String
            taxonomies: Array
    .expectJSONTypes 'name',
            sc: String
            ja: String
            alien: Boolean
            rank: String
            upper_id: String
    .expectJSONTypes 'taxonomies.*',
            sc: String
            ja: String
            rank: String
    .toss()


frisby
    .create 'GET birds/ヒドリガモ?fields=ja,alien'
    .get APIurl 'birds/ヒドリガモ?fields=ja,alien'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            name: Object
            binomen: String
            taxonomies: Array
    .expectJSONTypes 'name',
            sc: undefined
            ja: String
            alien: Boolean
            rank: undefined
            upper_id: undefined
    .expectJSONTypes 'taxonomies.*',
            sc: undefined
            ja: String
            rank: undefined
    .toss()

frisby
    .create 'GET birds/ヒドリガモ?fields=ja,unknownField'
    .get APIurl 'birds/ヒドリガモ?fields=ja,unknownField'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            name: Object
            binomen: String
            taxonomies: Array
    .expectJSONTypes 'name',
            sc: undefined
            ja: String
            alien: undefined
            rank: undefined
            upper_id: undefined
    .expectJSONTypes 'taxonomies.?',
            sc: undefined
            ja: String
            rank: undefined
    .toss()

frisby
    .create 'GET birds/ヒドリガモ?fields=onlyUnknownField'
    .get APIurl 'birds/ヒドリガモ?fields=onlyUnknownField'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            name: Object
            binomen: String
            taxonomies: Array
    .expectJSONTypes 'name',
            _id: String
            sc: undefined
            ja: undefined
            alien: undefined
            rank: undefined
            upper_id: undefined
    .expectJSONTypes 'taxonomies.*',
            _id: String
            sc: undefined
            ja: undefined
            alien: undefined
            rank: undefined
            upper_id: undefined
    .toss()


frisby
    .create 'GET existence/undefined-bird-species'
    .get APIurl 'existence/undefined-bird-species'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            existence: Boolean
            name: undefined
    .expectJSON '',
            existence: false
    .toss()


frisby
    .create 'GET existence/マガモ'
    .get APIurl 'existence/マガモ'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            existence: Boolean
            name: Object
    .expectJSON '',
            existence: true
    .toss()

frisby
    .create 'GET existence/マガモ?fields=ja'
    .get APIurl 'existence/マガモ?fields=ja'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            existence: Boolean
            name:
                _id: String
                ja: String
                sc: undefined
                rank: undefined
                upper_id: undefined
    .expectJSON '',
            existence: true
    .toss()


content = '''
日本ではカモ類の多くは渡り鳥ですが、カルガモは留鳥で、年中観察することができます。
マガモは渡りを行いますが、日本で繁殖する場合もあります。
滋賀県米原市にある三島池はマガモの繁殖の南限地として有名です。

琵琶湖では、コガモ、オナガガモ、キンクロハジロ、ホシハジロ、スズガモなどのカモ類が多く見られます。
これらのうち、コガモ、オナガガモ、キンクロハジロ、ホシハジロは狩猟鳥です。
コガモは狩猟者から「べ」と呼ばれます。
'''
birdsRefered = ['カルガモ','マガモ','コガモ','オナガガモ','キンクロハジロ','ホシハジロ','スズガモ']

frisby
    .create 'GET inclusion success'
    .get APIurl "inclusion?content=#{content}"
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSONTypes '',
            histogram: Array
    .expectJSONTypes 'histogram.*',
            species: Object
            frequency: Number
    .expectJSONLength 'histogram', birdsRefered.length
    .toss()


# frisby
#     .create 'GET inclusion success with fields query'
#     .get APIurl "inclusion?content=#{content}&fields=ja"
#     .expectStatus 200
#     .expectHeaderContains 'Content-Type', 'application/json'
#     .expectHeaderContains 'Content-Type', 'charset=UTF-8'
#     .expectHeaderContains 'Access-Control-Allow-Origin', '*'
#     .expectJSONTypes '',
#             histogram: Array
#     .expectJSONTypes 'histogram.*',
#             species:
#                 ja: String
#                 rank: undefined
#                 upper: undefined
#                 upper_id: undefined
#                 alien: undefined
#                 _id: undefined
#             frequency: Number
#     .expectJSONLength 'histogram', birdsRefered.length
#     .toss()



frisby
    .create 'GET inclusion with nocontent'
    .get APIurl 'inclusion'
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .expectJSON '',
            histogram: []
    .toss()


frisby
    .create 'POST distributions'
    .post APIurl('distributions'), {ja: 'ウズラ', place: '横浜'}, {json:true}
    .expectStatus 200
    .expectHeaderContains 'Content-Type', 'application/json'
    .expectHeaderContains 'Content-Type', 'charset=UTF-8'
    .expectHeaderContains 'Access-Control-Allow-Origin', '*'
    .after (err, res, body) ->
        frisby
            .create 'GET AFTER POST'
            .get APIurl 'distributions/ウズラ'
            .expectStatus 200
            .expectHeaderContains 'Content-Type', 'application/json'
            .expectHeaderContains 'Content-Type', 'charset=UTF-8'
            .expectHeaderContains 'Access-Control-Allow-Origin', '*'
            .expectJSON '',
                name: 'ウズラ'
            .expectJSON 'distributions.*',
                place: '横浜'
            .expectJSONTypes 'distributions.*',
                name_id: String
            .toss()
    .toss()


# frisby
#     .create 'POST distributions'
#     .post APIurl('distributions'), {ja: 'カワガラス', place: '川'}, {json:true}
#     .post APIurl('distributions'), {ja: 'カワガラス', place: '渓谷'}, {json:true}
#     .post APIurl('distributions'), {ja: 'ウミガラス', place: '海'}, {json:true}
#     .after (err, res, body) ->
#         frisby
#             .create 'GET AFTER POST'
#             .get APIurl 'distributions'
#             .expectStatus 200
#             .expectHeaderContains 'Content-Type', 'application/json'
#             .expectHeaderContains 'Content-Type', 'charset=UTF-8'
#             .expectHeaderContains 'Access-Control-Allow-Origin', '*'
#             .expectJSON '',
#                 name: 'ウズラ'
#             .expectJSON 'distributions.*',
#                 place: '横浜'
#             .expectJSONTypes 'distributions.*',
#                 name_id: String
#             .toss()
#     .toss()
