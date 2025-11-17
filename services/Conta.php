<?php

require_once 'Titular.php';

abstract class Conta
{
    protected int $numero;
    protected Titular $titular;
    protected float $saldo;

    /**
     * Construtor principal da conta.
     * @param int $numero O número da conta.
     * @param Titular $titular O objeto titular da conta.
     */
    public function __construct(int $numero, Titular $titular)
    {
        $this->setNumero($numero);
        $this->setTitular($titular);
        $this->saldo = 0.0;
    }

    // --- Setters ---

    public function setNumero(int $numero): void
    {
        if ($numero <= 0) {
            throw new InvalidArgumentException("O número da conta deve ser positivo.");
        }
        $this->numero = $numero;
    }

    public function setTitular(Titular $titular): void
    {
        if ($titular === null) {
            throw new InvalidArgumentException("O titular da conta não pode ser nulo.");
        }
        $this->titular = $titular;
    }

    // --- Getters ---

    public function getNumero(): int
    {
        return $this->numero;
    }

    public function getTitular(): Titular
    {
        return $this->titular;
    }

    public function getSaldo(): float
    {
        return $this->saldo;
    }
    abstract public function Depositar(float $valor): void;
    abstract public function Sacar(float $valor): void;

    public function __toString(): string
    {
        $saldoFormatado = number_format($this->saldo, 2, ',', '.');
        return "Conta Número: {$this->numero}, Titular: {$this->titular->getNome()}, Saldo: R$ {$saldoFormatado}";
    }

    public function Transferir(Conta $contaDestino, float $valor): void
    {
        if ($contaDestino === null) {
            throw new InvalidArgumentException("A conta de destino não pode ser nula.");
        }
        
        $this->Sacar($valor);
        $contaDestino->Depositar($valor);
    }
}