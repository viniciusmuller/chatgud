import { Component, Input, OnInit } from '@angular/core';
import { TruncatePipe } from '../pipes/truncate.pipe';
import { Post } from '../types/posts';

@Component({
  selector: 'app-post-preview',
  templateUrl: './post-preview.component.html',
  styleUrls: ['./post-preview.component.css']
})
export class PostPreviewComponent implements OnInit {
  @Input() post: Post | null;

  constructor() {
    this.post = null
  }

  ngOnInit(): void { }
}
