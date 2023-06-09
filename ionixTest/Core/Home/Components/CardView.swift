//
//  CardView.swift
//  ionixTest
//
//  Created by Angel  Rangel  on 08/06/2023.
//

import SwiftUI
import Kingfisher

//MARK: CARDVIEW Principal del Home


struct CardView: View {
    let meme: RedditChild

    var body: some View {
        LazyVStack (alignment: .leading){
            // Imagen
            
            KFImage(URL(string: meme.data.url))
                .resizable()
                .placeholder{
                    // Placeholder view while the image is loading
                    SpinnerCustom()
                        .padding()
                    
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 40,height: 209)
           
            // HStack
            HStack (alignment: .top) {
                // Score
                VStack  (alignment: .leading){
                    Image(systemName: "arrowtriangle.up.fill")
                    Text(String(meme.data.score ?? 0))
                        .fontWeight(.regular)
                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                    Image(systemName: "arrowtriangle.down.fill")
                       
                }
                .foregroundColor(Color.gray)
                .padding(EdgeInsets(top: 3, leading: 12, bottom: 3, trailing: 5))
                
               
                
                VStack (alignment: .leading){
                    // Título
                    Text(meme.data.title)
                        .font(.body)
                        .foregroundColor(Color.gray)
                        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
              
                    
                    // Comentarios
                    HStack {
                        Image(systemName: "ellipsis.message")
                       
                        Text("\(meme.data.num_comments)")
                            .fontWeight(.regular)
                    }.foregroundColor(Color.gray)
                }
                
                Spacer()
                
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 120)
            .background(Color.white)
            .padding(.zero)
            .listStyle(.plain)
          
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .listStyle(.plain)

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMeme = RedditChild(kind: "kind", data: RedditPost(title: "Mock Title", subreddit: "Mock Subreddit", selftext: "Mock Selftext", author_fullname: "Mock Author", created_utc: 1234567890, num_comments: 10, ups: 50, url: "https://www.example.com", link_flair_text: "Shitposting", post_hint: "", score: 30))
        
        CardView(meme: mockMeme)
    }
}
