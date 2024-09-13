FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    git \
    neovim \
    python3 \
    python3-pip \
    && apt-get clean

RUN useradd -ms /bin/bash nvimuser

USER root

RUN mkdir -p /home/nvimuser/.config/nvim && \
    mkdir -p /home/nvimuser/.local/share/nvim/lazy && \
    chown -R nvimuser:nvimuser /home/nvimuser

USER nvimuser
WORKDIR /home/nvimuser

RUN git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable /home/nvimuser/.local/share/nvim/site/pack/lazy/start/lazy.nvim

COPY . /home/nvimuser/.config/nvim/lua/ned-chtsh

RUN mkdir -p /home/nvimuser/.config/nvim/lua

RUN echo 'vim.g.mapleader = " "' >> /home/nvimuser/.config/nvim/init.lua && \
    echo 'local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"' >> /home/nvimuser/.config/nvim/init.lua && \
    echo 'if not vim.loop.fs_stat(lazypath) then' >> /home/nvimuser/.config/nvim/init.lua && \
    echo '  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})' >> /home/nvimuser/.config/nvim/init.lua && \
    echo 'end' >> /home/nvimuser/.config/nvim/init.lua && \
    echo 'vim.opt.rtp:prepend(lazypath)' >> /home/nvimuser/.config/nvim/init.lua && \
    echo 'require("lazy").setup({' >> /home/nvimuser/.config/nvim/init.lua && \
    echo '  { "ned-chtsh", dir = "/home/nvimuser/.config/nvim/lua/ned-chtsh" },' >> /home/nvimuser/.config/nvim/init.lua && \
    echo '})' >> /home/nvimuser/.config/nvim/init.lua && \
    echo 'vim.api.nvim_create_user_command("Cht", function() require("ned-chtsh").getCheatSheet() end, { desc = "Query cht.sh" })' >> /home/nvimuser/.config/nvim/init.lua && \
    echo 'vim.keymap.set("n", "<leader>cs", ":Cht<CR>", { desc = "[C]ht.[s]h query" })' >> /home/nvimuser/.config/nvim/init.lua

CMD ["nvim"]
