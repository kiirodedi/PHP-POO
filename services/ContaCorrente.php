<?php

require_once 'Conta.php'; 

class ContaCorrente extends Conta
{
    /**
     * @param int
     * @param Titular
     */
    public function __construct(int $numero, Titular $titular)
    {
        parent::__construct($numero, $titular);
    }

    /**
     * @param float
     * @throws InvalidArgumentException
     */
    public function Depositar(float $valor): void
    {
        if ($valor <= 0) {
            throw new InvalidArgumentException("O valor do depósito deve ser positivo.");
        }
        $this->saldo += $valor * 0.99; 
    }

    /**
     * @param float
     * @throws InvalidArgumentException
     * @throws RuntimeException
     */
    public function Sacar(float $valor): void
    {
        $valorComTaxa = $valor * 1.01; 

        if ($valor <= 0) {
            throw new InvalidArgumentException("O valor do saque deve ser positivo.");
        }

        if ($valorComTaxa > $this->saldo) {
            throw new RuntimeException("Saldo insuficiente para o saque de R$ " . number_format($valor, 2, ',', '.'));
        }

        $this->saldo -= $valorComTaxa;
    }

    public function __toString(): string
    {
        return "Conta Corrente - " . parent::__toString();
    }
}