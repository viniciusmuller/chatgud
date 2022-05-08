import { Injectable } from '@angular/core';
import { ApolloQueryResult } from '@apollo/client/core';
import { Apollo, ApolloBase, gql } from 'apollo-angular';
import { Observable } from 'rxjs';
import { Post, UserPublic } from './types/posts';

@Injectable({
  providedIn: 'root'
})
export class PostService {
  private apollo: ApolloBase;

  constructor(private apolloProvider: Apollo) {
    this.apollo = this.apolloProvider.use('dev')
  }

  public lastNPosts(n: number): Observable<ApolloQueryResult<Post[]>> {
    return this.apollo.watchQuery<Post[]>({
      query: gql`
        query LastNPosts($n: Int!){
          lastNPosts(n: $n) {
            id
            body
            title
          }
        }
      `,
      variables: {
        'n': n
      }
    }).valueChanges;
  }

  public newPosts(): any {
    return this.apollo.subscribe({
      query: gql`
        subscription newPost {
          id
          body
          title
        }
      `
    });
  }
}
