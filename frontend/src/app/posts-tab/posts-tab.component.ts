import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { Post } from '../types/posts';

@Component({
  selector: 'app-posts-tab',
  templateUrl: './posts-tab.component.html',
  styleUrls: ['./posts-tab.component.css']
})
export class PostsTabComponent implements OnInit, OnChanges {
  // TODO: Try to receive only the lists of posts in this component
  @Input() postsMap: { [id: string]: Post } = {};
  posts: Post[] = [];

  constructor() { }

  ngOnChanges(changes: SimpleChanges): void {
    console.log(changes)
    if (changes['postsMap']) {
      const newPostsMap = changes['postsMap'].currentValue;
      console.log("a", newPostsMap)
      if (newPostsMap) {
        this.posts = Object.values(newPostsMap)
      }
    }
    console.log(changes)
  }

  ngOnInit(): void { }
}
