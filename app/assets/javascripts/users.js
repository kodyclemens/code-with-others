class User{
  constructor(id, username, avatar, accountType) {
    this.id = id;
    this.username = username;
    this.avatar = avatar;
    this.type = accountType;
  }

  generateHTML() {
    let HTML = `
      <tr>
      <th scope="row">${this.id}</th>
      <td>${this.username}</td>
      <td><a href="/users/${this.id}">${this.username}'s Profile</a></td>
      <td>${this.type}</td>
      <td><img src="${this.avatar}" class="users-admin-list"></td>
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
    }
  });
});