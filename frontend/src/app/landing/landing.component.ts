import { Component, OnInit } from '@angular/core';
import { Post, UserPublic } from '../types/posts';

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.css']
})
export class LandingComponent implements OnInit {
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
        id: "unique comment id",
        karma: 0,
        creationDate: new Date(),
        updateDate: new Date(),
        body: "very nice!",
        author: this.user
      }
    ]
  }

  posts: Post[] = [
    this.post,
    this.post,
    this.post,
    this.post,
    this.post,
    this.post,
  ]

  currentPost: Post | null;

  constructor() {
    this.currentPost = null;
  }

  postSelected(postId: string) {
    this.currentPost = this.posts.filter(x => x.id == postId)[0]
  }

  ngOnInit(): void { }
}
