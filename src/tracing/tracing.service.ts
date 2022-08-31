import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Tracing, Prisma } from '@prisma/client';

@Injectable()
export class TracingService {
  constructor(private prisma: PrismaService) {}

  async createTracing(data: Prisma.TracingCreateInput): Promise<Tracing> {
    return this.prisma.tracing.create({
      data,
    });
  }
}
