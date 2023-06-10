# ionixApp


Proceso de inicialización
---------------


1. Leer detenida y detalladamente cada parte del PDF proporcionado por la compañia.
2. Identificar el flujo de negocio y flujo del usuario, apoyandome al escribir el flujo en papel para enterderlo mejor.
3. Identificar el API a utilizar e investigar un poco más a fondo con la documentación oficial.
4. Probar con Postman cada uno de los End Point requeridos.
5. Identificar el Json de respuesta para desarrollar el/los modelos de datos a utilizar.
6. Dado que es una app sencilla con un flujo definido escoger un framework/dependencia, patrones de diseño y arquitectura necesarias y eficientes. Para este proyecto me apoyé con: 
    
    ### Lenguaje de Pragramación: Swift 5+
    ### Framework: Swift UI - Combine.
    ### IDE: XCODE 14.2
    ### API development and testing tool:  POSTMAN.
    ### Patrones de diseño: Manager, Observer, Delegate.
    ### Arquitectura: MVVM.
    ### Dependencias externas: Kinfisher (Control de imagenes, download, guardado en cache).
    ### Manejador de dependencias: SPM (Swift Package Manager).
    
7. Categorizar cada una de las responsibilidades de la app para empezar a diseñar y desarrollar los Models y ViewModels.
8. Test Unitarios haciendo un uso básico de TDD para las funcionalidades principales:
    - Get Requets de Post.
    - Decodificar datos con Modelos de datos en swift 5+.
    - Filtro por categoría con el key:Value; "link_flair_text": "Shitposting".
    - Filtro por imagen con el key:Value; "post_hint": "image".
    - Get request de paginación con el uso del key "after".
    - Get request de search.
    - Filtro de usuarios por match con el key "title"
    
Aquí dejo la visualización de los filtros:

`swift`
``` 
func filterMemesBySearchText(meme: [RedditChild]?) {
        if let meme = memes {
            if !meme.isEmpty {
                print("Vacios")
                self.memes = meme.filter { $0.data.title.lowercased().contains(searchText.lowercased()) }

            }

        }
        
    }
    
    
    //MARK: Funcion para filtrar elementos segun la categoria y si tienen imagen
    func filterMemesAndImage(meme: [RedditChild]) -> [RedditChild] {
        return meme.filter { $0.data.link_flair_text == "Shitposting" && $0.data.post_hint == "image" }
    }
```


##  SplashScreen Animation


![IonixTestApp1](https://github.com/angelluiss/ionixApp/blob/master/imagesReadme/ionixgi1.gif)


##  Loading animation and permissions



![IonixTestApp2](https://github.com/angelluiss/ionixApp/blob/master/imagesReadme/ionixgif2.gif)


##  Home App


![IonixTestApp3](https://github.com/angelluiss/ionixApp/blob/master/imagesReadme/ionixgif3.gif)

