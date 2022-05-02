import { Component, Input, OnInit } from '@angular/core';
import { Post } from '../types/posts';

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css']
})
export class PostComponent implements OnInit {
  @Input() post: Post | null;

  constructor() {
    this.post = null
  }

  ngOnInit(): void { }
}
