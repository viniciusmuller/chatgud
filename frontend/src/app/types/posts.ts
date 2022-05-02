export interface Post {
  id: string;
  author?: UserPublic;
  comments?: Comment[];
  title: string;
  url?: string;
  body?: string;
  karma: number;
}

export interface UserPublic {
  id: string;
  username: string;
  comments?: Comment[]
  posts?: Post[]
}

export interface UserPrivate extends UserPublic {
  email: string;
}

export interface Comment {
  id: string;
  post?: Post;
  author?: UserPublic;
  body: string;
  karma: number;
}
