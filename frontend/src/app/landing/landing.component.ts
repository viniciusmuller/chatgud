import { Component, OnInit } from '@angular/core';
import { Post } from '../types/posts';

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.css']
})
export class LandingComponent implements OnInit {
  posts: Post[] = [
    { id: "aaa", title: "aa", karma: 0, body: "yeahhh boy" },
    { id: "aaa", title: "aa", karma: 0, body: "yeahhh boy" },
    { id: "aaa", title: "aa", karma: 0, body: "yeahhh boy" }
  ]

  currentPost: Post | null;

  constructor() {
    this.currentPost = null;
  }

  ngOnInit(): void { }
}
