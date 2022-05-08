import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { PostService } from '../post.service';
import { Post } from '../types/posts';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css']
})
export class FeedComponent implements OnInit {
  @Input() posts?: Post[];
  @Output('postSelected') postSelectedEvent = new EventEmitter<Post>();
  loading: boolean = true;

  constructor(private postService: PostService) { }

  ngOnInit(): void {
    this.postService.lastNPosts(5).subscribe(({ data, loading }) => {
      this.loading = loading;
      this.posts = (data as any).lastNPosts; // TODO figure out how to do this properly
    });
    this.postService.newPosts().subscribe((result: any) => {
      const newPost = result.data?.newPost;
      if (newPost && this.posts) {
        this.posts.push(newPost);
      }
    })
  }

  emitPostSelected(post: Post) {
    this.postSelectedEvent.emit(post);
  }
}
