import { Component, OnInit } from '@angular/core';
import { PostService } from '../post.service';
import { Post, UserPublic } from '../types/posts';

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.css']
})
export class LandingComponent implements OnInit {
  posts?: Post[];
  openedPosts: { [id: string]: Post } = {};
  currentPost?: Post;

  constructor(private postService: PostService) { }

  postSelected(postId: string) {
    if (this.posts) {
      const post = this.posts.filter(x => x.id == postId)[0];
      this.currentPost = post;

      let newOpenedPosts: { [id: string]: Post } = {}
      newOpenedPosts[postId] = post;
      this.openedPosts = Object.assign(newOpenedPosts, this.openedPosts);
    }
  }

  ngOnInit(): void {
    this.posts = this.postService.getPosts();
  }
}
