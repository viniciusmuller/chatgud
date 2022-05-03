import { Injectable } from '@angular/core';
import { Post, UserPublic } from './types/posts';

@Injectable({
  providedIn: 'root'
})
export class PostService {
  user: UserPublic = {
    username: "tester", joinDate: new Date(), id: "unique user id"
  };
  post: Post = {
    id: "aba", title: "a nice post", karma: 0,
    body: "a very nice body for a very nice post aaaaaaaaaaaa aaaaaaa cause then yeah tha's true",
    creationDate: new Date(), updateDate: new Date(),
    author: this.user,
    comments: [
      {
        id: "unique comment id",
        karma: 0,
        creationDate: new Date(),
        updateDate: new Date(),
        body: "very nice!",
        author: this.user
      },
      {
        id: "uniquee comment id",
        karma: 0,
        creationDate: new Date(),
        updateDate: new Date(),
        body: "very nice!",
        author: this.user
      }
    ]
  }
  post2: Post = {
    id: "aasfjkdafjklsdfkj;lba", title: "a nice post", karma: 0,
    body: "a very nice body for a very nice post aaaaaaaaaaaa aaaaaaa cause then yeah tha's true",
    creationDate: new Date(), updateDate: new Date(),
    author: this.user,
    comments: [
      {
        id: "unique comment id",
        karma: 0,
        creationDate: new Date(),
        updateDate: new Date(),
        body: "very nice!",
        author: this.user
      },
      {
        id: "uniquee comment id",
        karma: 0,
        creationDate: new Date(),
        updateDate: new Date(),
        body: "very nice!",
        author: this.user
      }
    ]
  }

  getPosts(): Post[] {
    return [
      this.post,
      this.post2
    ]
  }

  constructor() { }
}
