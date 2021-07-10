//
//  File.swift
//  Upscale
//
//  Created by Munyaradzi Hove on 2021-05-03.
//

import SwiftUI
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

struct HouseTypeRowView: View {
    
    @State var houseType: HouseType
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        HStack(spacing: 15){
            

            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(houseType.name)
                    .fontWeight(.bold)
                
                Text(houseType.detail)
                    .font(.caption)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
          
            
            if houseType.inOrOut == "moveIn" {
                
                            switch houseType.name  {
                            case "Single-Family House":
                                if viewRouter.OriginSelectorCounter == 1 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.OriginSelectorCounter = 1
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                               
                
                            case "Town House":
                                if viewRouter.OriginSelectorCounter == 2 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.OriginSelectorCounter = 2
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                
                            case "Apartment":
                                if viewRouter.OriginSelectorCounter == 3 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.OriginSelectorCounter = 3
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                                
                            case "Basement":
                                if viewRouter.OriginSelectorCounter == 4 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.OriginSelectorCounter = 4
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                                
                            case "Storage Unit":
                                if viewRouter.OriginSelectorCounter == 5 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.OriginSelectorCounter = 5
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                                
                            case "Customer":
                                if viewRouter.OriginSelectorCounter == 6 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.OriginSelectorCounter = 6
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                                
                            case "Business deliveries":
                                if viewRouter.OriginSelectorCounter == 7 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.OriginSelectorCounter = 7
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                
                            default:
                                Button(action: {}, label: {
                                    Image("")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color.black)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                        .frame(width: 25.0, height: 25.0)
                                })
                                
                            }
                
            }else{
                
                switch houseType.name  {
                
                case "Single-Family House":
                    if viewRouter.DestinationSelectorCounter == 1 {
                        Button(action: {}, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }else{
                        Button(action: {
                            viewRouter.DestinationSelectorCounter = 1
                        }, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }
                   
    
                case "Town House":
                    if viewRouter.DestinationSelectorCounter == 2 {
                        Button(action: {}, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }else{
                        Button(action: {
                            viewRouter.DestinationSelectorCounter = 2
                        }, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }
    
                case "Apartment":
                    if viewRouter.DestinationSelectorCounter == 3 {
                        Button(action: {}, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }else{
                        Button(action: {
                            viewRouter.DestinationSelectorCounter = 3
                        }, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }
                    
                case "Basement":
                    if viewRouter.DestinationSelectorCounter == 4 {
                        Button(action: {}, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }else{
                        Button(action: {
                            viewRouter.DestinationSelectorCounter = 4
                        }, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }
                    
                case "Storage Unit":
                    if viewRouter.DestinationSelectorCounter == 5 {
                        Button(action: {}, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }else{
                        Button(action: {
                            viewRouter.DestinationSelectorCounter = 5
                        }, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }
                case "Customer":
                    if viewRouter.DestinationSelectorCounter == 6 {
                        Button(action: {}, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }else{
                        Button(action: {
                            viewRouter.DestinationSelectorCounter = 6
                        }, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }
                    
                case "Business deliveries":
                    if viewRouter.DestinationSelectorCounter == 7 {
                        Button(action: {}, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }else{
                        Button(action: {
                            viewRouter.DestinationSelectorCounter = 7
                        }, label: {
                            Image("")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .frame(width: 25.0, height: 25.0)
                        })
                    }
    
                default:
                    Button(action: {}, label: {
                        Image("")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                            .frame(width: 25.0, height: 25.0)
                    })
                    
                }
                
            }
            
            //viewRouter.OriginSelectorCounter
            

            
            // Buttons...
           
            

        }
        .padding(.horizontal)
       
    }
}

struct FriendRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
