import { NgModule } from '@angular/core';
import { ApolloModule, APOLLO_NAMED_OPTIONS, NamedOptions } from 'apollo-angular';
import { InMemoryCache, split } from '@apollo/client/core';
import { HttpLink } from 'apollo-angular/http';
import { getMainDefinition } from '@apollo/client/utilities';
import { WebSocketLink } from '@apollo/client/link/ws';
import { OperationDefinitionNode } from 'graphql';

@NgModule({
  exports: [ApolloModule],
  providers: [
    {
      provide: APOLLO_NAMED_OPTIONS,
      useFactory(httpLink: HttpLink): NamedOptions {
        const http = httpLink.create({
          uri: 'http://localhost:4000/api/graphql',
        });

        // Create a WebSocket link:
        const ws = new WebSocketLink({
          uri: `ws://localhost:4000/api/ws`,
          options: {
            reconnect: true,
          },
        });

        // using the ability to split links, you can send data to each link
        // depending on what kind of operation is being sent
        const link = split(
          // split based on operation type
          ({ query }) => {
            const { kind, operation } = getMainDefinition(query) as OperationDefinitionNode;
            console.log(kind, operation)
            return (
              kind === 'OperationDefinition' && operation === 'subscription'
            );
          },
          ws,
          http,
        );

        return {
          dev: {
            cache: new InMemoryCache(),
            link: link
          }
          // Add other clients here
        };
      },
      deps: [HttpLink],
    },
  ],
})
export class GraphQLModule { }
