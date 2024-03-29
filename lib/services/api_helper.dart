class APIConfig {
  static const server = 'https://api.github.com';

  static String getUserReposUrl(String username) => '$server/users/$username/repos';

  static String getRepoCommitsUrl(String username, String repo) => '$server/repos/$username/$repo/commits';
}
