Swagger::Docs::Config.register_apis({
                                      '1.0' => {
                                        api_file_path: 'public/',
                                        base_path: 'http://localhost:3001',
                                        clean_directory: true,
                                        formatting: :pretty
                                      }
                                    })
