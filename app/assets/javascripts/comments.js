class Comment {
  constructor(content, user, image, userID, creatorID) {
    this.content = content;
    this.user = user;
    this.image = image;
    this.userID = userID;
    this.creatorID = creatorID;
  }

  updateDOM() {
    let badge = '';

    if (this.userID === this.creatorID) {
      badge = '<span class="badge badge-creator">Creator</span>';
    }

    const input =`
    <div class="media">
      <figure>
        <img src="${this.image}" class="align-self-start mr-3" alt="...">
        <br>
        <span class="badge badge-dark"><a href="/users/${this.userID}">${this.user}</a></span>
        ${badge}
        <div class="media-body">
          <p>${this.content}</p>
          <p class="figure-caption">Posted just now.</p>
        </div>
      </figure>
    </div>
    <hr>`;

    $('#comments').prepend(input);
    $('#comment_content').val('');
  }
}

$(document).ready(function() {
  let form = $('#new_comment');

  form.on('submit', function(e) {
    e.preventDefault();
    const params = $(this).serialize();
    const posting = $.post('/teams/1/comments', params);

    posting.done((data) => {
      let comment = new Comment(data.content, data.user.username,
        data.user.avatar_url, data.user.id, data.team.creator_id);
        comment.updateDOM();
        console.log(data);
    });
  });
});