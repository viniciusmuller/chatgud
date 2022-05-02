import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Post } from '../types/posts';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css']
})
export class FeedComponent implements OnInit {
  @Input() posts?: Post[];
  @Output('postSelected') postSelectedEvent = new EventEmitter<string>();

  constructor() {
    this.posts = [];
  }

  ngOnInit(): void { }

  emitPostSelected(post: Post) {
    this.postSelectedEvent.emit(post.id);
  }
}
