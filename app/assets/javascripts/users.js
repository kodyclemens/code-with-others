class User{
  constructor(id, username, avatar, accountType) {
    this.id = id;
    this.username = username;
    this.avatar = avatar;
    this.type = accountType;
  }

  generateHTML() {
    let HTML = `
      <tr id="${this.username}">
      <th scope="row">${this.id}</th>
      <td>${this.username}</td>
      <td><a href="/users/${this.id}">${this.username}'s Profile</a></td>
      <td>${this.type}</td>
      <td><img src="${this.avatar}" class="users-admin-list"></td>
      <td>
      <button type="button" class="btn btn-danger admin-delete-btn" id="user-${this.id}">Delete Account</button>
      </td>
      </tr>`;
    return HTML;
  }

  updateDOM() {
    $('#user_table').append(this.generateHTML());
  }
}

$(document).ready(function() {
  $.get('/users.json', function(data) {
    for (let i in data) {
      let user = new User(data[i].id, data[i].username, data[i].avatar_url, data[i].account_type);
      user.updateDOM();
      deleteListener(user.username);
    }
  });

  function deleteListener(username) {
    $('.admin-delete-btn').on('click', function(e) {
      e.preventDefault();
      let id = e.target.id.split('-')[1];
      let post = { id: parseInt(e.target.id.split('-')[1]), ref: 'admin' };
      let auth = $('meta[name=csrf-token]').attr('content');
      
      $.ajax({
          type: 'DELETE',
          url: `/users/${id}?&authenticity_token=${auth}`,
          data: post
        });
    
      $(`#${username}`).remove();
    });
  }
});