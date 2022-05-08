import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';
import { LandingComponent } from './landing/landing.component';
import { NavbarComponent } from './navbar/navbar.component';
import { FeedComponent } from './feed/feed.component';
import { PostPreviewComponent } from './post-preview/post-preview.component';
import { TruncatePipe } from './pipes/truncate.pipe';
import { PostComponent } from './post/post.component';
import { CommentComponent } from './comment/comment.component';
import { CommentTreeComponent } from './comment-tree/comment-tree.component';
import { PostsTabComponent } from './posts-tab/posts-tab.component';
import { GraphQLModule } from './graphql.module';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    PageNotFoundComponent,
    LandingComponent,
    NavbarComponent,
    FeedComponent,
    PostPreviewComponent,
    TruncatePipe,
    PostComponent,
    CommentComponent,
    CommentTreeComponent,
    PostsTabComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    GraphQLModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
