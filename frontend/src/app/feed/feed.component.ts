import { Component, Input, OnInit } from '@angular/core';
import { Post } from '../types/posts';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css']
})
export class FeedComponent implements OnInit {
  @Input() posts: Post[];

  constructor() {
    this.posts = [];
  }

  ngOnInit(): void {
  }

}
