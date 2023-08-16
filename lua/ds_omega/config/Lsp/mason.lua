return {
  'williamboman/mason.nvim',

  opts = {
    PATH = 'append',

    providers = {
      'mason.providers.client',
      'mason.providers.registry-api'   -- This is the default provider. You can still include it here if you want, as a fallback to the client provider.
    }
  },

  config = true,
}
