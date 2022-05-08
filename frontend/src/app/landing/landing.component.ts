import { Component, OnInit } from '@angular/core';
import { Post, UserPublic } from '../types/posts';

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.css']
})
export class LandingComponent implements OnInit {
  openedPosts: { [id: string]: Post } = {};
  currentPost?: Post;
  loading: boolean = true;

  constructor() { }

  postSelected(post: Post) {
    this.currentPost = post;
  }

  ngOnInit(): void { }
}
