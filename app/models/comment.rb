class Comment < PostAction
  default_scope order: 'post_actions.created_at ASC'
end