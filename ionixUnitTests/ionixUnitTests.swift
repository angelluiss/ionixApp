//
//  ionixUnitTests.swift
//  ionixUnitTests
//
//  Created by Angel  Rangel  on 09/06/2023.
//


import XCTest
@testable import ionixTest

class ionixUnitTests: XCTestCase {
    
    var viewModel: HomeVModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeVModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    //MARK: Test para comprobar la descarga de datos desde API
    func testFetchCombineMemes() {
        // Given
        let expectation = XCTestExpectation(description: "Memes fetched")
        viewModel.$loader
            .dropFirst() // Ignore initial value
            .sink { loader in
                if !loader {
                    expectation.fulfill()
                }
            }
            .store(in: &viewModel.cancellables)
        
        // When
        viewModel.fetchCombineMemes(nil)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.memes)
        XCTAssertFalse(viewModel.memes!.isEmpty)
    }
    
    //MARK: Test para comprobar la descarga de datos desde API por el search
    func testFetchCombineMemes2() {
        // Given
        let expectation = XCTestExpectation(description: "Memes fetched")
        viewModel.$loader
            .dropFirst() // Ignore initial value
            .sink { loader in
                if !loader {
                    expectation.fulfill()
                }
            }
            .store(in: &viewModel.cancellables)
        
        // When
        viewModel.fetchCombineMemes2(nil)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNil(viewModel.memes)
    }
    
    
    //MARK: Test para comprobar el filter de search

    func testFilterMemesBySearchText() {
        // Given
        // Creamos datos Mock para añadir al viewmodel
        let meme1 = RedditChild(kind: "te2", data:  RedditPost(title: "Mock Title",
                                                               subreddit: "Mock Subreddit",
                                                               selftext: "Mock Selftext",
                                                               author_fullname: "Mock Author",
                                                               created_utc: 1234567890,
                                                               num_comments: 10,
                                                               ups: 50,
                                                               url: "https://www.example.com",
                                                               link_flair_text: "Shitposting"
                                                               ,
                                                               post_hint: "image"
                                                               ,
                                                               score: 4
                                                               
                                             ))
        let meme2 = RedditChild(kind: "te2", data: MockRedditResponse.createMockRedditPost())
        let meme3 =  RedditChild(kind: "te2", data:  RedditPost(title: "Mock Title",
                                                                subreddit: "Mock Subreddit",
                                                                selftext: "Mock Selftext",
                                                                author_fullname: "Mock Author",
                                                                created_utc: 1234567890,
                                                                num_comments: 10,
                                                                ups: 50,
                                                                url: "https://www.example.com",
                                                                link_flair_text: "Shitposting"
                                                                ,
                                                                post_hint: "video"
                                                                ,
                                                                score: 4
                                                                
                                              ))
        
        // Seteamos el array con los datos Mock y colocamos una pabra que podamos encontrar en el ttitulo de al uno de los objetos
        viewModel.memes = [meme1, meme2, meme3]
        viewModel.searchText = "Mock"
        
        // When
        // Ejecuatamos el filtro
        viewModel.filterMemesBySearchText(meme: viewModel.memes)
        
        
        // Then
        // Probamos el tamaño de array o mejor dicho los elementos que contiene
        XCTAssertEqual(viewModel.memes?.count, 3)
        // VErificamos si realmente se encuentra o no los datos filtrados

        XCTAssertTrue(((viewModel.memes?.contains { $0.data.title == "Mock" }) != nil))
        XCTAssertTrue(((viewModel.memes?.contains { $0.data.title == "Not" }) != nil))
    }
    
    
    //MARK: Test para comprobar el filter categoria e imagen

    func testFilterMemesAndImage() {
        // Given
        // Creamos datos Mock para añadir al viewmodel
        let meme1 = RedditChild(kind: "te3", data: RedditPost(title: "Mock Title",
                                                                   subreddit: "Mock Subreddit",
                                                                   selftext: "Mock Selftext",
                                                                   author_fullname: "Mock Author",
                                                                   created_utc: 1234567890,
                                                                   num_comments: 10,
                                                                   ups: 50,
                                                                   url: "https://www.example.com",
                                                                   link_flair_text: "Shitposting"
                                                                   ,
                                                                   post_hint: "image"
                                                                   ,
                                                                   score: 4
                                                                   
                                                 ))
        
        let meme2 = RedditChild(kind: "te1", data: RedditPost(title: "Mock Title",
                                                                   subreddit: "Mock Subreddit",
                                                                   selftext: "Mock Selftext",
                                                                   author_fullname: "Mock Author",
                                                                   created_utc: 1234567890,
                                                                   num_comments: 10,
                                                                   ups: 50,
                                                                   url: "https://www.example.com",
                                                                   link_flair_text: "Shitposting"
                                                                   ,
                                                                   post_hint: "image"
                                                                   ,
                                                                   score: 4
                                                                   
                                                 ))
        
        let meme3 = RedditChild(kind: "te4", data: RedditPost(title: "Mock Title",
                                                                   subreddit: "Mock Subreddit",
                                                                   selftext: "Mock Selftext",
                                                                   author_fullname: "Mock Author",
                                                                   created_utc: 1234567890,
                                                                   num_comments: 10,
                                                                   ups: 50,
                                                                   url: "https://www.example.com",
                                                                   link_flair_text: "Shitposting"
                                                                   ,
                                                                   post_hint: "video"
                                                                   ,
                                                                   score: 4
                                                                   
                                                 ))
        
        let memes = [meme1, meme2, meme3]
        
        // When
        //Añadimos el array mock para setear data y simular un array de Objetos no vacio
        viewModel.memes = memes
        let filteredMemes = viewModel.filterMemesAndImage(meme: memes)
        
        // Then
        //Pocedemos a probar si se seteo correctamente el array

        XCTAssertEqual(filteredMemes.count, 0)
        
        
        //PRocedemos a probar si contiene o no los parametros que estamos filtrando para saber si es un meme y tiene imagen

        XCTAssertFalse(filteredMemes.contains { $0.data.link_flair_text == "Shitposting" })
        XCTAssertFalse(filteredMemes.contains { $0.data.post_hint == "image" })
        XCTAssertFalse(filteredMemes.contains { $0.data.link_flair_text != "Not Shitposting" })
        XCTAssertFalse(filteredMemes.contains { $0.data.link_flair_text != "video" })
       
    }

    
}

