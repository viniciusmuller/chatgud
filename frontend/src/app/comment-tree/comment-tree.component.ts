import { Component, Input, OnInit } from '@angular/core';
import { Comment } from '../types/posts';

@Component({
  selector: 'app-comment-tree',
  templateUrl: './comment-tree.component.html',
  styleUrls: ['./comment-tree.component.css']
})
export class CommentTreeComponent implements OnInit {
  @Input() comments?: Comment[];
  constructor() { }
  ngOnInit(): void { }
}
