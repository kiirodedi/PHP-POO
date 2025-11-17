<?php

class Titular
{
    private string $nome;
    private string $cpf;
    private string $endereco;

    /**
     * Construtor da classe Titular.
     * * @param string
     * @param string
     * @param string
     * @throws InvalidArgumentException
     */
    public function __construct(string $nome, string $cpf, string $endereco)
    {
        $this->setNome($nome);
        $this->setCpf($cpf);
        $this->setEndereco($endereco);
    }

    // --- Setters ---

    public function setNome(string $nome): void
    {
        $nomeLimpo = trim($nome);
        if (strlen($nomeLimpo) < 3) {
            throw new InvalidArgumentException("O nome do titular deve ter pelo menos 3 caracteres.");
        }

        if (preg_match('/[0-9]/', $nomeLimpo)) {
            throw new InvalidArgumentException("O nome do titular não pode conter números.");
        }

        $this->nome = $nomeLimpo;
    }

    public function setCpf(string $cpf): void
    {
        $cpfLimpo = preg_replace('/\D/', '', $cpf);

        if (strlen($cpfLimpo) !== 11 || !ctype_digit($cpfLimpo)) {
            throw new InvalidArgumentException("O CPF deve conter exatamente 11 dígitos numéricos.");
        }

        $this->cpf = $cpfLimpo;
    }

    public function setEndereco(string $endereco): void
    {
        if (trim($endereco) === '') {
            throw new InvalidArgumentException("O endereço não pode ser vazio.");
        }

        $this->endereco = $endereco;
    }

    // --- Getters ---

    public function getNome(): string
    {
        return $this->nome;
    }

    public function getCpf(): string
    {
        return $this->cpf;
    }

    public function getEndereco(): string
    {
        return $this->endereco;
    }

    public function __toString(): string
    {
        return "Nome: {$this->nome}, CPF: {$this->cpf}, Endereço: {$this->endereco}";
    }
}