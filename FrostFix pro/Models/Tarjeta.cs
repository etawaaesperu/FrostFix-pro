using System;
using System.Collections.Generic;

namespace FrostFix_pro.Models;

public partial class Tarjeta
{
    public int Id { get; set; }

    public string? Marca { get; set; }

    public string? Numero { get; set; }

    public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
}
