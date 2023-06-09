//
//  MemeModel.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//


import Foundation

//MARK: No es un Modelo, es un SUPER MODELO. Que te ayudara a decodificar la data que obtengas de tu API REST


struct RedditResponse: Codable {
   
    let kind: String
    let data: RedditData
    
    init( kind: String, data: RedditData) {
  
        self.kind = kind
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decodificar cada propiedad requerida
        kind = try container.decode(String.self, forKey: .kind)
        data = try container.decode(RedditData.self, forKey: .data)
    }
}

struct RedditData: Codable {
    let after: String
    let children: [RedditChild]

    enum CodingKeys: String, CodingKey {
        case after
        case children = "children"
    }
    
    init(after: String, children: [RedditChild]) {
        self.after = after
        self.children = children
      
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decodificar cada propiedad requerida
        after = try container.decode( String.self, forKey: .after)
        children = try container.decode( [RedditChild].self, forKey: .children)
    }
}

struct RedditChild: Codable, Identifiable {
    let id = UUID()
    let kind: String
    let data: RedditPost
    
    init(kind: String, data: RedditPost) {
        self.kind = kind
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decodificar cada propiedad requerida

        kind = try container.decode(String.self, forKey: .kind)
        data = try container.decode(RedditPost.self, forKey: .data)
    }
}


struct RedditPost: Codable {
   
    let title: String
    let subreddit: String
    let selftext: String
    let author_fullname: String
    let created_utc: Double
    let num_comments: Int
    let ups: Int
    let url: String
    let link_flair_text: String?
    let post_hint: String?
    let score: Int?

    enum CodingKeys: String, CodingKey {
       
        case title
        case subreddit
        case selftext
        case author_fullname
        case created_utc
        case num_comments
        case ups
        case url
        case link_flair_text
        case post_hint
        case score
    }
    
    init( title: String, subreddit: String, selftext: String, author_fullname: String, created_utc: Double,num_comments: Int,ups: Int, url:  String, link_flair_text: String?
          , post_hint: String?
          , score: Int?
    ) {
     
        self.title = title
        self.subreddit = subreddit
        self.selftext = selftext
        self.author_fullname = author_fullname
        self.created_utc = created_utc
        self.num_comments =  num_comments
        self.ups = ups
        self.url = url
        self.link_flair_text = link_flair_text
        self.post_hint = nil
        self.score = score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decodificar cada propiedad requerida
      
        title = try container.decode(String.self, forKey: .title)
        subreddit = try container.decode(String.self, forKey: .subreddit)
        selftext = try container.decode(String.self, forKey: .selftext)
        author_fullname = try container.decode(String.self, forKey: .author_fullname)
        created_utc = try container.decode(Double.self, forKey: .created_utc)
        num_comments =  try container.decode(Int.self, forKey: .num_comments)
        ups = try container.decode(Int.self, forKey: .ups)
        url = try container.decode(String.self, forKey: .url)
        link_flair_text = try container.decode(String?.self, forKey: .link_flair_text)
        post_hint = try container.decodeIfPresent(String.self, forKey: .post_hint)
        score = try container.decode(Int?.self, forKey: .score)
        
    }
}

//MARK: Modelo de generacion de Mock para maquetacion, pruebas unitarias y pruebas de UI

struct MockRedditResponse {
    static func createMockData() -> RedditResponse {
        let child1 = RedditChild(kind: "kind1", data: createMockRedditPost())
        let child2 = RedditChild(kind: "kind2", data: createMockRedditPost())
        let children = [child1, child2]
        let data = RedditData(after: "",children: children)
        return RedditResponse(kind: "responseKind", data: data)
    }
    
    static func createMockRedditPost() -> RedditPost {
        return RedditPost(title: "Mock Title",
                          subreddit: "Mock Subreddit",
                          selftext: "Mock Selftext",
                          author_fullname: "Mock Author",
                          created_utc: 1234567890,
                          num_comments: 10,
                          ups: 50,
                          url: "https://www.example.com",
                          link_flair_text: ""
                          ,
                          post_hint: ""
                          ,
                          score: 4
                          
        )
    }
}






