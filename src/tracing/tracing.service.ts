import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Tracing, Prisma } from '@prisma/client';

import { UpdateTracingDto } from './dto/update-tracing.dto';
@Injectable()
export class TracingService {
  constructor(private prisma: PrismaService) {}

  async tracing(
    tracingWhereUniqueInput: Prisma.TracingWhereUniqueInput,
  ): Promise<Tracing | null> {
    return this.prisma.tracing.findUnique({
      where: tracingWhereUniqueInput,
    });
  }

  async tracings(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.TracingWhereUniqueInput;
    where?: Prisma.TracingWhereInput;
    orderBy?: Prisma.TracingOrderByWithRelationInput;
  }): Promise<Tracing[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.tracing.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async createTracing(data: Prisma.TracingCreateInput): Promise<Tracing> {
    return this.prisma.tracing.create({
      data,
    });
  }

  async updateTracing(
    id: number,
    updateTracingDto: UpdateTracingDto,
  ): Promise<Tracing> {
    return this.prisma.tracing.update({
      data: updateTracingDto,
      where: { id },
    });
  }

  async deleteTracing(where: Prisma.TracingWhereUniqueInput): Promise<Tracing> {
    return this.prisma.tracing.delete({
      where,
    });
  }
}
