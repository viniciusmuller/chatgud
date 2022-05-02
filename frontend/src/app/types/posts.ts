export interface Post {
  id: string;
  author?: UserPublic;
  comments?: Comment[];
  title: string;
  url?: string;
  body?: string;
  karma: number;
  creationDate: Date;
  updateDate: Date;
}

export interface UserPublic {
  id: string;
  username: string;
  comments?: Comment[]
  posts?: Post[]
  joinDate: Date;
}

export interface UserPrivate extends UserPublic {
  email: string;
}

export interface Comment {
  id?: string;
  parentId?: string;
  post?: Post;
  author?: UserPublic;
  body: string;
  karma: number;
  creationDate: Date;
  updateDate: Date;
}
